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

We will once again predict the tree species for forest areas in Rhineland-Palatinate. The same prepared and balanced dataset as in the last exercise will be used. Leave-location-out cross-validation is used as spatial cross-validation. For this purpose, the pixels of all polygons are separated into folds, with the function CreateSpacetimeFolds, using their ID. The folds are then passed to the trainControl function as an index.

```r
# 1 - set up ####
#---------------#

library(caret)
library(foreach)
library(doParallel)
library(CAST)
library(randomForest)

# 2 - leave-location-out (LLO) cross-validation ####
#--------------------------------------------------#


# leave location out cross-validation
indices <- CreateSpacetimeFolds(extr, spacevar = "FAT__ID", k=10, class = "BAGRu")


set.seed(10)
ctrl <- trainControl(method="cv",index = indices$index,
                     savePredictions=TRUE )


```

Instead of using the train function of the caret package, now we use the ffs function from the [CAST package](https://cran.r-project.org/web/packages/CAST/index.html). We do not apply any model tuning, but you should expect that the prediction will take a long time, since the many predictor variables have to be trained with each other. 

```r
# 3 - Forward-Feature-Selection (FFS) ####
#----------------------------------------#

# no model tuning
tgrid <- expand.grid(.mtry = 2,
                     .splitrule = "gini",
                     .min.node.size = 1)



predictors = extr[,1:130]
response = extr[,"BAGRu"]
response$BAGRu <- as.factor(response$BAGRu)

#run ffs model with Leave-Location-out CV
#set.seed(10)
cl <- makeCluster(10)
registerDoParallel(cl)
set.seed(10)


ffsmodel <- ffs(predictors,
                response$BAGRu, 
                metric="Kappa", 
                method="rf",
                trControl=ctrl, 
                importance = TRUE ,
                tuneLength = 1, 
                ntree = 50)

stopCluster(cl)

ffsmodel
saveRDS(ffsmodel, "ffsmodel.RDS")


```
Now predict the tree species again and compare the results as well as the selected variables to the results you achieved in unit 03. What are differences, similarities and peculiarities? 
{: .notice--primary}