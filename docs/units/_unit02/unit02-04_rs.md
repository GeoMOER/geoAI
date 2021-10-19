---
title: EX | Remote Sensing - classification hands on 
toc: true
header:
  image: /assets/images/unit02/31031723265_0890cd9547_o.jpg
  image_description: "Cloudscape Over the Philippine Sea"
  caption: "Image: [NASA's Marshall Space Flight Center](https://www.nasa.gov/centers/marshall/home/index.html) [CC BY-NC 2.0] via [flickr.com](https://www.flickr.com/photos/nasamarshall/31031723265/)"
---

Remote sensing is a core method in all spatial knowledge sciences . It is used to generate knowledge about the properties and processes of the Earth's surface, the atmosphere but also in all microscale imaging techniques.

<!--more-->

In the geosciences it is the only measurement technique that provides complete coverage of large spatial scales.  Necessarily, research also includes the development of own methods, especially with respect to the processing chains, but also in the coupling of suitable established methods.  

Specifically in environmental informatics, the detection of changes using satellite, aircraft and drone imagery is a central component. Often this is used in conjunction with bio- and geophysical or human induced processes for a deeper understanding and the possibility to develop predictive models.
Central to this are image analysis methods to extract information that allows the underlying processes to be identified. An increasingly important component is the integration of Big Data analytics.

The growing and now already overwhelming flood of imagery and remote sensing data available needs to be readily accessed and used for both scientific knowledge gain and societal future challenges. This practical application will be started in this exercise.

## Assesment
Raw or original satellite images are not necessarily informative. We can interpret a true-color image, but a reliable and reproducible scientific interpretation requires other approaches. Moreover, specific additional information can be derived by image processing methods. We have already learned about the NDVI. Also the derivation from the surface albedo is the phsically based conversion of image singnals into a phsical quantity. 
 Consequently, in order to obtain useful information about, for example, land cover in an area, we need to analyze the data in a goal-directed manner.  The best known and most common approach is to classify the images into categories of interest.

This exercise introduces the classification of satellite and aerial survey data and classification in R.  We will cover the following:

1. Preparing the work environment and loading the data
2. Use of a variety of new packages and signature helper functions
1. Quick & dirty digtalization of training areas 
3. unsupervised/supervised classification 
  * kmeans (via RStoolbox)
  * recursive partitioning and regression trees (via rpart)
  * random forest (via caret) 
  


For this tutorial we use the Sentinel 2 images from the previous exercise. You may also use the digitized classes from the exercise before. However, the method can be used with virtually any data from earth observation satellites and aerial surveys. 

## Step 1 - Start with setting up the script
You can either use the saved data from the last unit or download and edit a new section for practice. In principle, however, the working environment is loaded first.
```r
#------------------------------------------------------------------------------
# Type: script
# Name: hands-on.R
# Author: Chris Reudenbach, creuden@gmail.com
# Description:  retrieves sentinel data 
#               defines AOI and performs classification tasks
# Dependencies: geoAI.R  
# Output: original sentinel tile 
#         AOI window of this tile (research_area)
#         unsupervised classification with kmeans (via RStoolbox)
#         supervised classification recursive partitioning and regression trees (via rpart)
#         random forest (via caret) 
#         superclust (automated random forest via RStoolbox)# Copyright: Chris Reudenbach 2021, GPL (>= 3)
# git clone https://github.com/gisma-courses/courses-scripts/geoAI.git
#------------------------------------------------------------------------------

# 0 - specific setup
#-----------------------------
library(envimaR)
appendpackagesToLoad = c("rprojroot","sen2R","terra","patchwork","ggplot2",
                         "mapedit","dplyr","mapview","tidyverse","rpart","rpart.plot",
                         "rasterVis","caret","forcats","RStoolbox","randomForest",
                         "e1071")

# add define project specific subfolders
appendProjectDirList = c("data/sentinel/",
                         "data/vector_data/",
                         "data/sentinel/S2/",
                         "data/sentinel/SAFE/",
                         "data/sentinel/research_area/")

source(file.path(envimaR::alternativeEnvi(root_folder = "~/edu/geoAI",
                                          alt_env_id = "COMPUTERNAME",
                                          alt_env_value = "PCRZP",
                                          alt_env_root_folder = "F:/BEN/edu"),
                 "src/geoAI_setup.R"))


# 2 - define variables
#---------------------

# subsetting the filename(s) of the interesting file(s)
fn_noext=xfun::sans_ext(basename(list.files(paste0(envrmt$path_research_area,"/BOA/"),pattern = "S2B2A")))
fn = basename(list.files(paste0(envrmt$path_research_area,"/BOA/"),pattern = "S2B2A"))

# creating a raster stack
stack=raster::stack(paste0(envrmt$path_research_area,"/BOA/",fn))


```
## Step 2 - Using helper functions and packages

In general, we could program almost everything ourselves using the basic raster/terra and sp/sf packages. However, the effort is enormous. Especially R lives from the community and over 20 K tested packages. In addition, there are countless blogs and code snippets provided by users and developers. Here it is definitely the art to find the "right" or more suitable material and make it usable. For the given task we now use a variety of packages and some functions.

For didactical and understanding reasons we will use (somehow arbitrary) some helper functions from Sydney Goldsteins [Blog](https://urbanspatial.github.io/classifying_satellite_imagery_in_R/) that deals with classifying of satellite images. 

Please note that there are a lot of blogs and help outside([rspatial - supervised   classification](https://rspatial.org/raster/rs/5-supclassification.html), [RPubs Tutorial](https://rpubs.com/ials2un/rf_landcover), [Blog](https://urbanspatial.github.io/classifying_satellite_imagery_in_R/) that deals with classifying of satellite images. 
[supervised classification](https://www.r-exercises.com/2018/03/07/advanced-techniques-with-raster-data-part-2-supervised-classification/) [pixel based supervised classification](https://valentinitnelav.github.io/satellite-image-classification-r/)).
None of them is  intended to be a scientific or content reference. It is like the last blog author Valentin Stefan mentioned *"[...]Treat this content as a blog post and nothing more. It does not have the pretention to be an exhaustive exercise nor a replacement for your critical thinking.[...]"* 

However it is rather an example of how from such sources (all more or less technically similar) described how something is done, a specific set of tools emerges. This is a god starting point and after a lot of research and critical examination it emerge somehow  to the current state of the art of the community.
So please check if all libraries are available.
```r
 c("rprojroot","sen2R","terra","patchwork","ggplot2",
 "mapedit","dplyr","mapview","tidyverse","rpart","rpart.plot",
 "rasterVis","caret","forcats","RStoolbox","randomForest", "e1071")
```
## Step 3 - Capture training data 
The next step is optional but offers the possibility to quickly and effectively digitize some training areas without leaving the RStudio world. For larger tasks, it is essential to refer to the high comfort of the QGIS working environment as decribed in (see also [EX	Digitizing training areas](unit02-03_digitize_training_areas.html)). For this exercise we use `mapedit` a small but nice package that allows onscreen digitizing in Rstudio or in a browser.  In combination with mapview it is really comfortable for fastforward digitizing. Especially helpfull is the comfortable way to produce true or false [color composites](https://custom-scripts.sentinel-hub.com/custom-scripts/sentinel-2/composites/). 

### Color Composites for better training results

Just to remember with the following command you will create a Sentinel true color composite. If you combine them with a `+` you will receive on object with both layers.

```r
# sentinel truecolor composite 
mapview::viewRGB(stack, r = 4, g = 3, b = 2) + mapview::viewRGB(stack, r = 8, g = 4, b = 3)
```

{% include media1 url="assets/images/unit02/cc.html" %}
[Full-screen version of the map]({{ site.baseurl }}/assets/images/unit02/cc.html){:target="_blank"} 
<figure>
  <figcaption>Sentinel 2 True Color Composite RGB (4, 3, 2),  Date: 2021-06-13 Region Marburg Open Forest.
  Use the layer control to toggle the layers.
  True color composites assign the visible spectral channels red (B04), green (B03), and blue (B02) to the corresponding red, green, and blue color channels, respectively, resulting in a quasi-naturally "colored" image of the surface as it would be seen by a human sitting on the satellite.
  False color images are often produced with the spectral channels near infrared, red and green.  It is excellent for estimating vegetation because plants reflect near infrared and green light while absorbing red light (Red Egde Effect). Denser plant cover is darker red. Cities and open ground are gray or light brown, and water appears blue or black. 
  </figcaption>
</figure>


### Digitize fast forward training data

We specify that we want to classify four types of land cover: forest, fields, meadows and settlements.
Each class is digitized and typed in a single way. 

```r
fields <- mapview::viewRGB(stack, r = 8, g = 4, b = 3) %>% mapedit::editMap()
```
{% include figure image_path="/assets/images/unit01/fields.png" alt="The mapedit GUI. After digitizing click on DONE." %}

Then carry out the next step. This will assign the attributes *class* and *id*.
```r
fields <- train_area$finished$geometry %>% st_sf() %>% mutate(class = "fields", id = 2)
```

We call the image composite that makes sense for us (False Color) with the following command. The digitization with mapedit is mostly self-explanatory and GUI-supported and is finished with 'Done'.

```r
# note we can combine each of the Sentinel channels to derive a true or false color composite

# digitizing all areas with forest only
train_area <- mapview::viewRGB(stack, r = 8, g = 4, b = 3) %>% mapedit::editMap()
# add class (text) and id (integer number)
forest <- train_area$finished$geometry %>% st_sf() %>% mutate(class = "forest", id = 1)

# fields only
train_area <- mapview::viewRGB(stack, r = 4, g = 3, b = 2) %>% mapedit::editMap()
fields <- train_area$finished$geometry %>% st_sf() %>% mutate(class = "fields", id = 2)

# meadows only
train_area <- mapview::viewRGB(stack, r = 4, g = 3, b = 2) %>% mapedit::editMap()
meadows <- train_area$finished$geometry %>% st_sf() %>% mutate(class = "meadows", id = 3)

# settlements only
train_area <- mapview::viewRGB(stack, r = 8, g = 4, b = 3) %>% mapedit::editMap()
settlement <- train_area$finished$geometry %>% st_sf() %>% mutate(class = "settlement", id = 4)

# bind it together to one file
train_areas <- rbind(forest, fields, meadows, settlement)

# save results
saveRDS(train_areas, paste0(envrmt$path_sentinel,"train_areas.rds"))

``` 

## Step 4 - Classification 
There are numerous methods to classify data in feature space. In principle, these can be *unsupervised* or *supervised*.  In the case of unsupervised methods, the number of classes is usually specified and statistical methods are used to search for the best possible aggregation within the number of these classes in the feature space. 

#### Manipulating the training data 
First of all we have to prepare the digitized data. That means we have to arragne it for several algorithms we want to use.

```r
# first of all we have to project the data into correct crs
tp = sf::st_transform(train_areas,crs = sf::st_crs(stack))
## - next step  extracting of the values from all bands of the raster stack 
# we force to return  the values as an data frame
# extract the raster way very slow
DF <- raster::extract(stack, tp, df=TRUE) 
# for simplicity  we rename the layers
names(DF) = c("id","band1","band2","band3","band4","band5","band6","band7","band8","band9","band10","band11")
# no we add the "class" category which is needed later on for the training
# it was dropped during extraction
DF_sf =st_as_sf(inner_join(DF,tp))
# finally we produce a simple data frame without geometry
DF2 = DF_sf
st_geometry(DF2)=NULL
```


### K-Means clustering out of the box
The best known is the `K-means` clustering which could be called one of the simplest unsupervised machine learning algorithms.
In our example applied for 4 classes and for simplicity executed with `RStoolbox` it looks like this:

```r
## kmeans via RStoolbox
prediction_kmeans = unsuperClass(stack, nSamples = 25000, nClasses = 4, nStarts = 25,
                                 nIter = 250, norm = TRUE, clusterMap = TRUE,
                                 algorithm = "MacQueen")
mapview(prediction_kmeans$map, col = c('darkgreen', 'burlywood', 'green', 'orange'))

```
{% include media1 url="assets/images/unit02/kmeans.html" %}
[Full-screen version of the map]({{ site.baseurl }}/assets/images/unit02/kmeans.html){:target="_blank"} 
<figure>
  <figcaption>K-means clustering based on Sentinel2 channels 1-11, Date: 2021-06-13 Region Marburg Open Forest, As you can see and interactively compare without doing anything we get an visually pretty good classification </figcaption>
</figure>

### Recursive Partitioning and Regression Trees
Our first supervised algorithm belongs to the family of non-linear classification algorithms which is based on decision trees.Classification and Regression Trees (CART) split attributes (our training data) based on values that minimize a loss function, such as sum of squared errors. They are fast and pretty efficient.

```r
# defining the model 
cart <- rpart(as.factor(DF2$class)~., data=DF2[,2:12], method = 'class')# the tree
rpart.plot(cart, box.palette = 0, main = "Classification Tree")
```
{% include figure image_path="/assets/images/unit02/cart_tree.png" alt="CART tree as derived from the upper model. You can see each split and the probabilities." %}

After calcculationg the model and checking the tree  we succed with the prediction. That means the model is applied to the original data stack and according to the tree splits the pixels are classified.

```r
prediction_cart <- raster::predict(stack, cart, type='class', progress = 'text')  
mapview(prediction_cart,col.regions = c('darkgreen', 'burlywood', 'green', 'orange'))
```

{% include media1 url="assets/images/unit02/cart.html" %}
[Full-screen version of the map]({{ site.baseurl }}/assets/images/unit02/cart.html){:target="_blank"} 
<figure>
  <figcaption>CART classification based on Sentinel2 channels 1-11, Date: 2021-06-13 Region Marburg Open Forest, As you can see and interactively compare this is obviusly more sophisticated than running a K-means clustering it is heavily depending on the training data </figcaption>
</figure>

### Random forest decision trees
Random Forest is a classification and regression method consisting of arbitrary uncorrelated decision trees. The decision trees are generated iteratively during a training (learning) process. For a classification, each (decision) tree in this forest of decision trees is allowed to represent one decision. The class (in our case e.g. fields) with the most individual trees decides the final classification. It is one of the most used methods of machine learning because it is robust, versatile and in the top group of ML methods in terms of efficiency.

```r
## random forest via caret
set.seed(123)
# split data into train and test data and take only a fraction of them
trainDat =  DF2[createDataPartition(DF2$id,list = FALSE,p = 0.25),]
# define a training control object for caret with crossvalidation 10 repeats
ctrlh = trainControl(method = "cv", 
                     number = 10, 
                     savePredictions = TRUE)
# train random forest via caret model 
cv_model = train(trainDat[,2:12],
                 trainDat[,13],
                 method = "rf",
                 metric = "Kappa",
                 trControl = ctrlh,
                 importance = TRUE)


prediction_rf  = predict(stack ,cv_model, progress = "text")
mapview(prediction_rf,col.regions = c('darkgreen', 'burlywood', 'green', 'orange'))

```

{% include media1 url="assets/images/unit02/rf.html" %}
[Full-screen version of the map]({{ site.baseurl }}/assets/images/unit02/rf.html){:target="_blank"} 
<figure>
  <figcaption> Random Forest classification based on Sentinel2 channels 1-11, Date: 2021-06-13 Region Marburg Open Forest, As you can see and interactively compare this out of the box rf classification is bette than CART However it is still  pretty poor. So also heavily depending on the training data and hence tuning</figcaption>
</figure>

### CART with a priory knowledge

We recall the CART model but this time we use an estimate of how muchproportion of each class we are expecting. this knowledge is know as a-priory knowledge. Let's see if we can improve the results. 
```r
# defining the model 
cart <- rpart(as.factor(DF2$class)~., data=DF2[,2:12], method = 'class',
              parms = list(prior = c(0.65,0.25,0.05,0.05)))# the tree
rpart.plot(cart, box.palette = 0, main = "Classification Tree")
```
{% include media1 url="assets/images/unit02/cart_priory.html" %}
[Full-screen version of the map]({{ site.baseurl }}/assets/images/unit02/cart_priory.html){:target="_blank"} 
<figure>
  <figcaption>CART classification based on Sentinel2 channels 1-11, Date: 2021-06-13 Region Marburg Open Forest, As you can see helping out with some a-priory estimation yields in better results </figcaption>
</figure>


What we see is tehre is a lot to learn how to deal with the sampling of trainingdata and tuning of the models.

## Assignment Unit-2-2

Now that some basics have been explained, it's time to practice again on your own. The following tasks serve as an orientation framework within which you can practice in a targeted manner.

{% capture Assignment-1-2 %}
1. Please apply the upper techniques  on either  (1) downloading  a NEW sentinel dataset for the training data as derived by the course server or (2) apply t directly on the airborne imagery dataset.
1. Read and operate the following [section](https://rspatial.org/raster/rs/5-supclassification.html). Please apply the evaluation and tuning part on the above CART model. What is your finding with respect to model quality and improvement?
1. Please read  [Review of classifcatin approaches](https://isgindia.org/wp-content/uploads/2017/04/016.pdf)


{% endcapture %}
<div class="notice--success">
  {{ Assignment-1-2 | markdownify }}
</div> 



## Where can I find more information?
For more information, you can look at the following resources: 

* [Straightforward overview RS and classification](https://gisgeography.com/image-classification-techniques-remote-sensing/)

* [Typical workflow](https://www.mdpi.com/2072-4292/9/10/1048)


