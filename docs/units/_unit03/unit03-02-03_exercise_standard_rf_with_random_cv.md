---
title: "Exersice: Standard Random Forest Model with random Cross-Validation und internem Fehler als Gütemaß"
---

You can use the Docker environment that is part of this course.

## Extract values from Sentinel2 and lindar indices and bands.


## Split the data

* Split your data into a training and testing set with `caret::createDataPartition()`. The training set should inherit 60% of the data. The testing set the other 40% accoringly.


## Random forest
create your own random forest model to predict the tree species in Rhineland-Palatinate

* Train a random forest model with `ranger::ranger()` using your training set.
* Predict the tree species groups 
* 

## Assignment
Write everything in a Rmd file, knitr it and upload the html file to Ilias. 




