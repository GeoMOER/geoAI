---
title: EX | A randomly good model

header:
  image: /assets/images/unit03/dice_blue_2.jpg
  image_description: "Cutout Autumn impressions"
  caption: "Bild: [flickr](https://www.flickr.com/photos/192004829@N02/51145500105/) / CC BY-NC 2.0"

---
Creation of a Random Forest Model with random cross-validation.

## Extraction

Extract the values of Sentinel-2 band indices and lidar indices for your training polygons.


## Random forest
create your own random forest model to predict the tree species in Rhineland-Palatinate

* Train a random forest model using your training set.
* Predict the tree species groups 


```r
#######################################
#### A "random" Random Forest Model ###
#######################################

library(caret)
library(CAST)

# set control settings to random cross-validation
ctrl <- trainControl(method="cv",
                     number =10,
                     savePredictions = TRUE)


# train a standard random forest model
set.seed(100)
model <- caret::train(predictors,
                      response,
                      method="ranger",
                      metric="Accuracy",
                      trControl=ctrl,
                      importance=TRUE,
                      ntree=77)
```
**Note:** If you run out of RAM you can reduce your data with caret::createDataPartition()
{: .notice--info}

## Assignment
Write everything in a Rmd file, knitr it and upload the html file to Ilias. 




