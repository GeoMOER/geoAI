---
title: EX | A randomly good model
toc: true
header:
  image: /assets/images/unit03/streuobst.jpg
  image_description: "Apples under tree"
  caption: "Image: manfredrichter via [pixabay.com](https://pixabay.com/de/photos/%C3%A4pfel-streuobst-obstbaum-apfelbaum-3684775/)"
 
---
Create a random forest model with random cross-validation.

## Read the data
In the first step you need your previously prepared predictor variables (DOP and indices) and the **Streuobstwiese** polygons. Combine all of your raster layers into one raster stack and ensure that each layer name is unique. 

```r
# 1 - read your data ####
#-----------------------#

rasterStack = raster::stack(file.path(envrmt$sentinel, "sentinel.tif"))
# Polygons:
pol = sf::read_sf(file.path(envrmt$hlnug, "streuobst.gpkg"))
``` 
Also check if your predictors and response have the same projection. Also make sure that each polygon has a unique ID. If the data does not include an ID number, add one.

```r
pol = sf::st_transform(pol, crs(rasterStack))
pol$OBJ_ID = 1:nrow(pol)
```
 
## Extract the data 
For each pixel in a training polygon we now want to extract each value in the predictor raster stack. You can think about the polygons like cookie cutters and the raster stack like several layers of cookie dough stacked on top of each other -- we want to cut the data out of each raster that corresponds to the polygon area, i.e. the **Streuobstwiese**. The data gets formatted to a dataframe that we can merge with the original polygons. In this way we get back the class information of the polygons.

```r
# 2 - extract polygons from raster stack ####
#-----------------------#

result = lapply(seq(nrow(pol)), function(i){
	cur = pol[i,]
    ext <- raster::extent(cur)
    
      all = raster::crop(rasterStack, ext)
      
      df = raster::extract(all, cur, df = TRUE)
      df = df %>% dplyr::mutate(cur %>% select(OBJ_ID)
      df$ID <- NULL
      
      print(paste("Extracted Polygon", i, "of", nrow(pol)))
      return(df)
  }) # end lapply
  
  
# format the extraction
res = result[sapply(result, is.data.frame)]
res = do.call(rbind, res)
return(res)

extr_merge = merge(res,pol, by = "OBJ_ID")
saveRDS(extr_merge, file.path(envrmt$model_training_data, "extraction.RDS"))
```

## Balancing
To balance the data, we will use the dataframe with the extracted values for each pixel. *This is important because...* The first step is to divide the polygons into a training and a test group. Here, we will use 80% of the polygons for training and the remaining 20% of the polygons for testing. 

```r
# 3 - balancing ####
#------------------#

extr = readRDS(file.path(envrmt$model_training_data, "extraction.RDS"))

# Sample 80 percent of training polygon IDs
train_ids = sample(unique(extr$OBJ_ID), length(unique(extr$OBJ_ID))*0.8)

# Filter the extracted dataframe
extr_train = extr%>%filter(OBJ_ID %in% train_ids)
```
Then, compare the number of training pixels per class. If the number is not identical, which is very likely, we will sample the same amount of pixel for each class.

```r
# Number Pixels per class
nrow(filter(extr_train, class == "other"))
nrow(filter(extr_train, class == "SO"))

extr_train = extr_train %>% 
 group_by(class)%>%
  sample_n(nrow(filter(extr_train, class == "SO")))

# Control
n_distinct(filter(extr_train, class == "other"))
n_distinct(filter(extr_train, class == "SO"))
```

## Random Forest
Now you can start your first attempt to predict **Streuobstwiese**. As discussed before, we will use a simple random forest model with 10-fold cross-validation. Define your train control settings and use the `train` function from the package `caret` [(on CRAN)]( https://cran.r-project.org/web/packages/caret/index.html) to train your model. It is also worth taking a look at the book [The caret Package]( https://topepo.github.io/caret/).

```r
# 1 - set up ####
#---------------#

library(caret)
library(terra)
library(sf)

predictors = extr[,2:39]
response = extr[,"class"]
response <- as.factor(response$class)
```

Define your response and predictors, the response is just one column containing your class label, while the predictors are all the columns containing the information extracted from your raster stack. Be careful not to include anything else in your dataframe (e.g. the geometry).

```r
# 2 - set control settings to random cross-validation ####
#--------------------------------------------------------#

ctrl <- trainControl(method="cv",
                     number =10, #  number of folds
                     savePredictions = TRUE)
```

Train a simple random forest model using the `caret` package. The `train` function offers the method "rf". You could also explore other implementations of the random forest algorithm in `R`, for example the `ranger` [package](https://cran.r-project.org/web/packages/ranger/index.html), which performs better. Feel free to do some model tuning, as well.

```r
# 3 - train a standard random forest model ####
#---------------------------------------------#

set.seed(100)
model <- caret::train(predictors,
                      response,
                      method="rf",
                      metric="Kappa",
                      trControl=ctrl,
                      importance = TRUE,
                      ntree=77)

saveRDS(model, "model.RDS")
```

Now that you have a fully developed random forest model, you can predict the tree species for the whole study area. Take a closer look at the accuracy and Kappa values as well as the variable importance. Are there any things that stand out to you?

## Prediction
Since you probably want to admire your results now, it is worth bringing your model into the area by making a prediction on your predictor raster stack with your finished model.

```r
model <- readRDS(file.path(envrmt$models, "model.RDS"))
rasterStack = raster::stack(file.path(envrmt$sentinel, "sentinel.tif"))
   
prediction <- terra::predict(rasterStack, model, na.rm = TRUE)
   
terra::writeRaster(prediction, file.path(envrmt$prediction, paste0(species, "_pred.tif")), overwrite = TRUE)
saveRDS(prediction, file.path(envrmt$prediction, paste0(species, "_pred.RDS")))
```

## Validation
Finally, we need one more very important thing: a validation with independent data that has not been included in the model training. For this we use the 20% of the polygons that we left out at the beginning. Simply do the same extraction again as you did at the beginning for the training. Then a prediction is made for all pixels, and the predicted values are compared to the observed values in a matrix.

```r
model = readRDS(file.path(envrmt$models, paste0(model, "_ffs.RDS")))
predicted = stats::predict(object = mod, newdata = extr_val)
  
val_df = data.frame(ID = pull(extr_sub, idCol),
                      Observed = pull(extr_val, "class"), 
                      Predicted = predicted)
  
val_cm = confusionMatrix(table(val_df[,2:3]))
  
# output
saveRDS(val_cm, file.path(envrmt$validation, "confusionmatrix.RDS"))
```