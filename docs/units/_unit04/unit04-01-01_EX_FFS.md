---
title: EX | Spatial Prediction
toc: true
header:
  image: /assets/images/unit04/header_ffs.png
  image_description: "Excerpt of predicted tree species groups in Rhineland-Palatinate"
  caption: "Image: © GeoBasis-DE / LVermGeoRP 2018; © OpenStreetMap-contributors; © Hansen/UMD/Google/USGS/NASA; © ESA - produced from ESA remote sensing data"
---

Spatial prediction, right this time!

## Forward-Feature Selection with spatial cross-validation

 


```r
# 1 - set up ####
#---------------#

library(caret)
library(foreach)
library(doParallel)
library(CAST)
library(randomForest)

# 2 - train control ####
#----------------------#

### Initialise Leave-Location out cv
## Main difference in the modelling strategy: we combine multiple location in the folds
# sample a ten fold cv stratified after the main tree species (BAGRu)
# spacevar = "FAT__ID" divides the polygon IDs into different folds
# CAST version 0.4.2


# leave location out cross-validation
indices <- CreateSpacetimeFolds(extr, spacevar = "FAT__ID", k=10, class = "BAGRu")

### Initialize Modelling

set.seed(10)
ctrl <- trainControl(method="cv",index = indices$index,
                     savePredictions=TRUE )



# no model tuning
tgrid <- expand.grid(.mtry = 2,
                     .splitrule = "gini",
                     .min.node.size = 1)



predictors = extr[,1:130]
response = extr[,"BAGRu"]
response$BAGRu <- as.factor(response$BAGRu)
#run ffs model with Leave Location out CV
#set.seed(10)
ffsmodel <- ffs(predictors,response$BAGRu, method="rf",
                trControl=ctrl, ntree = 50)

ffsmodel
saveRDS(ffsmodel, "ffsmodel.RDS")


```
