---
title: EX | Spatial Prediction
toc: true
header:
  image: /assets/images/unit03/streuobst.jpg
  image_description: "Apples under tree"
  caption: "Image: manfredrichter via [pixabay.com](https://pixabay.com/de/photos/%C3%A4pfel-streuobst-obstbaum-apfelbaum-3684775/)"
 
---

In this exercise, we will predict buildings in the southern part of Marburg once again. This time, however, it will be a spatial prediction done right -- which is to say that the results will not be spatially autocorrelated and much more robust! You can use the same dataset that we prepared and balanced in the previous exercise. 

You can import your extracted data in the same manner as before. In this case, we also need to define the column that contains information about which row belongs to which polygon (Polygon ID).

```r
training =  readRDS(file.path(envrmt$path_model_training_data, "extr_train.RDS")) 


# random forest
predictors = training[,3:10]
response = training[,"class"]
```

## Leave-Location-Out Cross-Validation
Use a Leave-Location-Out Cross-Validation as a spatial cross-validation technique. For this purpose, the function `CreateSpacetimeFolds` separates the pixels of every polygon into folds, based on their ID.

```r
# leave location out cross-validation
indices <- CreateSpacetimeFolds(training, 
                                spacevar = "OBJ_ID", 
                                k=10, 
                                class = "class")
```

The folds are then passed to the `trainControl` function as an index.

```r

set.seed(10)
ctrl <- trainControl(method="cv",
                     index = indices$index,
                     savePredictions=TRUE,
                     allowParallel = TRUE)
```

## Forward-Feature-Selection

Instead of using the `train` function from the `caret` package, we now use the function `ffs` from the [CAST package](https://cran.r-project.org/web/packages/CAST/index.html). We do not apply any model tuning, but you should expect that the prediction will take a long time, since the many predictor variables all have to be trained with each other. 

```r
#Forward-Feature-Selection (FFS)
#no model tuning
tgrid <- expand.grid(mtry = 2,
                     splitrule = "gini",
                     min.node.size = 1)

#run ffs model with Leave-Location-out CV
#set.seed(10)

ffsmodel <- ffs(predictors,
                response,
                method = "ranger",
                trControl =ctrl,
                tuneGrid = tgrid,
                num.trees = 100,
                importance = "permutation")

ffsmodel
saveRDS(file.path(envrmt$path_unit03_models), "ffsmodel.RDS")
```

Now predict the location of buildings again and compare the results as well as the selected variables to the results from the traditional random forest model (with random CV). What are differences, similarities and peculiarities? 


{% capture Assignment-03-2 %}

## Assignment Unit-03-2

Add assignment
1. ...
2. ...

{% endcapture %}
<div class="notice--success">
  {{ Assignment-03-2 | markdownify }}
</div> 

## Comments?
You can leave comments under this gist if you have questions or comments about any of the code chunks that are not included as gist. Please copy the corresponding line into your comment to make it easier to answer the question. 

<script src="https://utteranc.es/client.js"
        repo="GeoMOER/geoAI"
        issue-term="GeoAI_2021_unit_03_EX_Spatial_prediction"
        theme="github-light"
        crossorigin="anonymous"
        async>
</script>
