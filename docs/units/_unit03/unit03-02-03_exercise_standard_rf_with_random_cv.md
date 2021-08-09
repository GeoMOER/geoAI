---
title: EX | A randomly good model

header:
  image: /assets/images/unit03/dice_blue_2.jpg
  image_description: "Cutout Autumn impressions"
  caption: "Image: The Focal Project [CC BY-NC 2.0] via [flickr.com](https://www.flickr.com/photos/192004829@N02/51145500105/)"

---
Creation of a Random Forest Model with random cross-validation.

## Extraction

Extract the values of Sentinel-2 band indices and lidar indices for your training polygons.

```r
# input
library(terra)
library(sf)



train = sf::read_sf("C:/Users/Lisa Bald/Uni_Marburg/KI_Kampus/Exercise/Unit03/train.gpkg")
train = train[train$proz > 80,]
train = subset(train, select = c("FAT__ID", "BAGRu"))
sen = terra::rast("C:/Users/Lisa Bald/Uni_Marburg/KI_Kampus/Exercise/Unit03/summer.grd")
rlp_forest_buffer = train


# extract all polygons from raster stack
#i = 340
result = lapply(seq(nrow(rlp_forest_buffer)), function(i){
  print(i)
  cur = rlp_forest_buffer[i,]
  ext <- ext(cur)
  
    # if bigger than 10 m:
    sen = crop(sen, ext)

    df = raster::extract(sen, vect(cur), df = TRUE)
    df$FAT__ID = cur$FAT__ID
    print("Extracted")
    return(df)
  }
)

#p = data.frame(FAT__ID = rlp_forest_buffer$FAT__ID)#, 
#               status = do.call(c, protocoll))
write.csv(p, "data/RLP_extration_protocoll.csv", quote = FALSE, row.names = FALSE)


# formating of extraction

res = result[sapply(result, is.data.frame)]
res = do.call(rbind, res)
saveRDS(res, "C:/Users/Lisa Bald/Uni_Marburg/KI_Kampus/Exercise/Unit03/RLP_extract.RDS")


```

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




