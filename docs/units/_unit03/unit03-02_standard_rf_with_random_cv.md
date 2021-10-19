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
# rasterStack containing the bands red, green, blue and nir
rasterStack = raster::stack(file.path(envrmt$path_raw_data_aerial, "marburg_dop_rgbi.tif"))
# also load the indices you calculated in the last exercise:
indices = raster::stack(file.path(envrmt$path_unit03_aerial, "dop_indices.tif"))

# add all to one raster stack:
rasterStack = raster::stack(rasterStack, indices)



``` 
Also check if your raster and polygons have the same projection. Also make sure that each polygon has a unique ID. If the data does not include an ID number, add one.

```r
# now the vector data: load the file with the sf package  and check if the crs is matching with the raster stack
pol = sf::read_sf(file.path(file.path(envrmt$path_raw_data_vector, "marburg_buildings_selfmade.gpkg")))
pol = sf::st_transform(pol, crs(rasterStack))
# also if you haven´t done it already, add IDs to your polygons
pol$OBJ_ID = 1:nrow(pol)

```
 
## Extract the data 
For each pixel in a training polygon we now want to extract each value in the predictor raster stack. You can think about the polygons like cookie cutters and the raster stack like several layers of cookie dough stacked on top of each other -- we want to cut the data out of each raster that corresponds to the polygon area, i.e. the **Streuobstwiese**. The data gets formatted to a dataframe that we can merge with the original polygons. In this way we get back the class information of the polygons.

```r
# to extract the data use raster::extract or the much faster package exactextractr
extr = exact_extract(rasterStack, pol, include_cols = c( "class",  "OBJ_ID"))
extr = extr[sapply(extr, is.data.frame)]
extr = do.call(rbind, extr)


saveRDS(extr, file.path(envrmt$path_model_training_data, "extraction.RDS"))

```

## Balancing
To balance the data, we will use the dataframe with the extracted values for each pixel. *This is important because...* At first we will check how many pixel of each class are in our dataframe. We will then downsample the larger class. Therefore we will randomly sample the same amount of rows from the larger class that is available in the smaller class. 

```r
extr = readRDS(file.path(envrmt$path_model_training_data, "extraction.RDS"))
extr = na.omit(extr)

buildings = extr[extr$class == "building",]
other = extr[extr$class == "other",]

nrow(buildings)
nrow(other)

# reduce the larger class by sampling the same amount of rows as are contained in the smaller class
set.seed(42)
other = other[sample(nrow(buildings)), ]

# combine the two dataframes
extr = rbind(other, buildings)

```
Then we will split the data into one dataframe for the model training, containing 80% of the data and one for testing containing 20% of the data. We will use the function createDataPartition from the caret package for this task. This function is very useful as it tries to maintain the ratio of each class in the datasets.
```r
trainIndex = caret::createDataPartition(extr$class, p = 0.8, list = FALSE)
training = extr[ trainIndex,]
testing = extr[ -trainIndex,]


saveRDS(training, file.path(envrmt$path_model_training_data, "extr_train.RDS"))
saveRDS(testing, file.path(envrmt$path_model_training_data, "extr_test.RDS"))
```

## Random Forest
Now you can start your first attempt to predict **Streuobstwiese**. As discussed before, we will use a simple random forest model with 10-fold cross-validation. Define your train control settings and use the `train` function from the package `caret` [(on CRAN)]( https://cran.r-project.org/web/packages/caret/index.html) to train your model. It is also worth taking a look at the book [The caret Package](https://topepo.github.io/caret/).

```r

training = na.omit(training)
training$class <- as.factor(training$class)
# random forest
predictors = training[,3:10]
response = training[,"class"]

```

Define your response and predictors, the response is just one column containing your class label, while the predictors are all the columns containing the information extracted from your raster stack. Be careful not to include anything else in your dataframe (e.g. the geometry).

```r
# set control settings to random cross-validation

ctrl <- trainControl(method="cv",
                     number =10, #  number of folds
                     savePredictions = TRUE)
					 
tgrid <- expand.grid(mtry = 2:4,
				splitrule = "gini",
				min.node.size = c(10, 20)
)					 
					 
```

Train a simple random forest model using the `caret` package. The `train` function offers the method "rf". You could also explore other implementations of the random forest algorithm in `R`, for example the `ranger` [package](https://cran.r-project.org/web/packages/ranger/index.html), which performs better. Feel free to do some model tuning, as well.

```r
# train a standard random forest model 

set.seed(100)

cl <- makeCluster(4)
registerDoParallel(cl)

model <- train(predictors,
               response,
               method = "ranger",
               trControl =ctrl,
               tuneGrid = tgrid,
               num.trees = 100,
               importance = TRUE)



stopCluster(cl)

saveRDS(model, "model.RDS")
```

Congratulations, you have a fully developed random forest model! Now, you can predict the tree species for the whole study area. Take a closer look at the accuracy and Kappa values as well as the variable importance. What stands out to you about the values?

## Prediction
Since you probably want to admire your results now, it is worth bringing your model into the area by making a prediction on your predictor raster stack with your finished model.

```r
model <- readRDS(file.path(envrmt$models, "model.RDS"))
   
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