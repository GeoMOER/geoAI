---
title: LM | Spatially Good
toc: true
header:
  image: /assets/images/unit03/streuobst.jpg
  image_description: "Apples under tree"
  caption: "Image: manfredrichter via [pixabay.com](https://pixabay.com/de/photos/%C3%A4pfel-streuobst-obstbaum-apfelbaum-3684775/)"
 
---

Resilient spatial predictions using appropriate selection and validation strategies.
<!--more-->

In spatial forecasting, there are some special features that must be taken into account when selecting methods. Spatial data cannot be treated like other data sets. As already mentioned in Unit 1, proximity does not necessarily have anything to do with context. Nevertheless, proximity is an important issue when we try to validate spatial models. In the last exercise, we created a random forest model that is validated with a 10-fold random cross validation. To do this, the dataset was randomly split, ignoring the information of where exactly the pixels were once in space when selecting validation and training datasets. This can result in pixels from a polygon being used for both training and validation. This leads to spatial auto correlation of the data. This means that the data set, which should actually be used to validate the model, has too much similarity with the training data set, so that the model is estimated to be significantly better than it actually is (see e.g [Ploton et al. 2020]( https://www.nature.com/articles/s41467-020-18321-y)). 
To tackle this problem we will now validate our random forest model with a method that is better suited for spatial data, we will swap the random cross-validation with a spatial [Leave-Location-Out (LLO)](https://www.rdocumentation.org/packages/CAST/versions/0.5.1/topics/CreateSpacetimeFolds) cross-validation. For this we use the function CreateSpacetimeFolds from the R package [CAST]( https://cran.r-project.org/web/packages/CAST/CAST.pdf).
To do this, the pixels are grouped in a dataframe according to their membership in a polygon, so that only whole locations (polygons) are used for either validation **or** training, thus preventing us from assuming the model is better than it actually is.

To perform a spatial variable selection, we will use another function from the same package, a [Forward-Feature-Selection (FFS)](https://www.rdocumentation.org/packages/CAST/versions/0.2.0/topics/ffs). 

Familiarize yourself with the topics by reading the corresponding article.


## Further reading
[Meyer H, Reudenbach C, Hengl T, Katurji M, Nauss T (2018) Improving performance of spatio-temporal machine learning models using forward feature selection and target-oriented validation. Environmental Modelling & Software 101: 1–9. https://doi.org/10.1016/j.envsoft.2017.12.001.](https://www.sciencedirect.com/science/article/abs/pii/S1364815217310976)

[Meyer H, Reudenbach C, Wöllauer S, Nauss T (2019) Importance of spatial predictor variable selection in machine learning applications – Moving from data reproduction to spatial prediction](https://www.sciencedirect.com/science/article/abs/pii/S0304380019303230#!)

## Still Questions?
We highly recommend the following talk, which addresses the issues in more detail:

* [Hanna Meyer: "Machine-learning based modelling of spatial and spatio-temporal data"(53:24)](https://www.youtube.com/watch?v=QGjdS1igq78&t=2676s)