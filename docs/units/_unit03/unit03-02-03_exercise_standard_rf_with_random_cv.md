---
title: EX | A randomly good model
toc: true
header:
  image: /assets/images/unit03/forest.jpg
  image_description: "Cutout Autumn impressions"
  caption: "Image: Ranger56112 [CC BY-NC 2.0] via [flickr.com](https://www.flickr.com/photos/ranger56112/21714329483/)"
 
---
Creation of a Random Forest Model with random cross-validation.

## Extract the data

In the first step you need your previously prepared Sentinel-2 and forest inventory data. Combine all raster layers into one raster stack and ensure that each layername is unique. Then you can extract all pixel values for each polygon from the raster layers. If you have problems with insufficient memory you can also use [this tutorial](https://ilias.uni-marburg.de/data/UNIMR/lm_data/lm_2285471/unit05/unit04-07_spatial_trainingdata.html), which excludes very similar layers from the beginning.
```r
# 1 - read your data ####
#-----------------------#

library(terra)
library(sf)

# read forest inventory data
train = read_sf("train.gpkg")
train$ID = 1:nrow(train)
train = subset(train, select = c("FAT__ID", "BAGRu"))
# read lidar and Sentinel-2
extrStack = terra::rast("extractionStack.tif")

# 2 - extraction ####
#-------------------#

extr = terra::extract(extrStack, vect(train))
extr = merge(extr, train, by.x = "ID", by.y = "ID")

saveRDS(extr, "extraction.RDS")
```

## Balancing
Now you have a dataframe that contains the extracted values for each training pixel. Look at how many training pixels are available for each tree species. The number of tree species is probably very imbalanced, therefore the data should be balanced so that each tree species has the same number of training pixels available.
Feel free to use [this script](https://github.com/envima/ForestModellingRLP/blob/master/src/functions/007_balancing.R) to balance your data or create your own method.
```r
# 1 - set up #####
#----------------#


library(tidyverse)

# 2 - read the data ####
#----------------------#
extr = readRDS("extraction.RDS")

extr$geom <- NULL
extr$ID <- NULL
extr <- na.omit(extr)

# 3 - balancing #####
#-------------------#

source("007_balancing.R")
extr = balancing(extr, 
                 response = "BAGRu", 
                 class = c("Fi", "Ei", "Ki", "Bu", "Dou"))


```
## Random Forest


Now you can already predict the tree species. As discussed before, we use a simple random forest model with 10-fold cross-validation.  Define your train control settings and use the train function from the [caret package]( https://cran.r-project.org/web/packages/caret/index.html) to train your model. It is also worth taking a look at the book [The caret Package]( https://topepo.github.io/caret/).

```r
# 1 - set up ####
#---------------#

library(caret)
library(terra)
library(sf)

# 2 - set control settings to random cross-validation ####
#--------------------------------------------------------#

ctrl <- trainControl(method="cv",
                     number =10, #  number of folds
                     savePredictions = TRUE)



# 3 - train a standard random forest model ####
#---------------------------------------------#

predictors = extr[,1:130]
response = extr[,"BAGRu"]
response$BAGRu <- as.factor(response$BAGRu)

set.seed(100)
model <- caret::train(predictors,
                      response$BAGRu,
                      method="rf",
                      metric="Kappa",
                      trControl=ctrl,
                      importance = TRUE,
                      ntree=77)


saveRDS(model, "model.RDS")
```

Now that you have a fully developed Random Forest Model, you can predict the tree species for the whole study area. Look at the Accuracy and Kappa values as well as the Variable Importance. Are there any things that stand out to you?
{: .notice--primary}