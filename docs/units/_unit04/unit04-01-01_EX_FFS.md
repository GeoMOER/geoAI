---
title: EX | Spatial Prediction
toc: true
header:
  image: /assets/images/unit04/header_ffs.png
  image_description: "Excerpt of predicted tree species groups in Rhineland-Palatinate"
  caption: "Image: © GeoBasis-DE / LVermGeoRP 2018; © OpenStreetMap-contributors; © Hansen/UMD/Google/USGS/NASA; © ESA - produced from ESA remote sensing data"
---

## Räumliche Vorhersage, diesmal richtig. 



FFS, LLO-CV, 
Zufällige Wahl einer Teilmenge von Trainingsgebieten o.ä.

## Exercise

* run the ffs with a small amount of training data use caret::createDataPartition for this
* create a loop over the leave-location-out cross-validation for each fold (link!)
* 


```r
# Include Example of FFS with spatial cross-validation
# Modelling of the main tree classes for RLP

rm(list=ls())


library(caret)
library(foreach)
library(doParallel)
library(CAST)
library(randomForest)

## choose model response
#response_type<-"meta_classes_main_trees"

train = sf::read_sf("C:/Users/Lisa Bald/Uni_Marburg/KI_Kampus/Exercise/Unit03/train.gpkg")
train = train[train$proz > 80,]
train = subset(train, select = c("FAT__ID", "BAGRu"))


# load modelling data
pred_resp<-readRDS("C:/Users/Lisa Bald/Uni_Marburg/KI_Kampus/Exercise/Unit03/RLP_extract.RDS")
pred_resp <- merge(pred_resp, train, by.x = "FAT__ID", by.y = "FAT__ID")
rm(train)
### Initialise Leave-Location out cv
## Main difference in the modelling strategy: we combine multiple location in the folds
# sample a ten fold cv stratified after the main tree species (BAGRu)
# spacevar = "FAT__ID" divides the polygon IDs into different folds

indices <- CreateSpacetimeFolds(pred_resp, spacevar = "FAT__ID", k=10, class = "BAGRu")



### Initialize Modelling

set.seed(10)
ctrl <- trainControl(method="cv",index = indices$index,
                     savePredictions=TRUE )



# no model tuning
tgrid <- expand.grid(.mtry = 2,
                     .splitrule = "gini",
                     .min.node.size = 1)


predictors <- pred_resp[,3:14]
response <- factor(pred_resp$BAGRu)

#run ffs model with Leave Location out CV
#set.seed(10)
ffsmodel <- ffs(pred_resp[,3:14],factor(pred_resp[,"BAGRu"]), method="rf",
                trControl=ctrl, ntree = 50)

ffsmodel


```
