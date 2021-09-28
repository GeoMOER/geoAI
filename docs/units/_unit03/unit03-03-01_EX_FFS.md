---
title: EX | Spatial Prediction
toc: true
header:
  image: /assets/images/unit03/streuobst.jpg
  image_description: "Apples under tree"
  caption: "Image: manfredrichter via [pixabay.com](https://pixabay.com/de/photos/%C3%A4pfel-streuobst-obstbaum-apfelbaum-3684775/)"
 
---
Spatial prediction, right this time!


We will once again predict orchard meadows in Hesse. You can use the same prepared and balanced dataset as in the last exercise. Use a Leave-location-Out cross-validation as spatial cross-validation. For this purpose, the pixels of all polygons are separated into folds, with the function CreateSpacetimeFolds, using their ID. The folds are then passed to the trainControl function as an index.


```r
# 1 - set up ####
#---------------#

library(caret)
library(foreach)
library(doParallel)
library(CAST)
library(randomForest)

predResp = readRDS(file.path(envrmt$model_training_data, "extraction.RDS")) 
predictors = extr[,2:39]
response = extr[,"class"]
response = as.factor(response$class)

spacevar = "OBJ_ID"
```
## Leave-Location-out Cross-Validation


```r

# 2 - leave-location-out (LLO) cross-validation ####
#--------------------------------------------------#


# leave location out cross-validation
indices <- CreateSpacetimeFolds(extr, spacevar = "FAT__ID", k=10, class = "class")


set.seed(10)
ctrl <- trainControl(method="cv",index = indices$index,
                     savePredictions=TRUE )


```

## Forwad-Feature-Selection

Instead of using the train function of the caret package, now we use the ffs function from the [CAST package](https://cran.r-project.org/web/packages/CAST/index.html). We do not apply any model tuning, but you should expect that the prediction will take a long time, since the many predictor variables have to be trained with each other. 

```r
# 3 - Forward-Feature-Selection (FFS) ####
#----------------------------------------#

# no model tuning
tgrid <- expand.grid(.mtry = 2,
                     .splitrule = "gini",
                     .min.node.size = 1)




#run ffs model with Leave-Location-out CV
#set.seed(10)

ffsmodel <- ffs(predictors,
                response$BAGRu, 
                metric="Kappa", 
                method="rf",
                trControl=ctrl, 
                importance = TRUE ,
                tuneLength = 1, 
                ntree = 50)



ffsmodel
saveRDS(ffsmodel, "ffsmodel.RDS")


```

Now predict the tree species again and compare the results as well as the selected variables to the results you achieved with the traditional random forest model. What are differences, similarities and peculiarities? 
{: .notice--primary}