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

We are once again trying to predict orchard meadow in Hesse. This time we will use two new methods to improve the predictions. To address the issue of autocorrelation in spatial predictions (see e.g [Ploton et al. 2020]( https://www.nature.com/articles/s41467-020-18321-y)) we will swap the random cross-validation with a spatial [Leave-Location-Out (LLO)](https://www.rdocumentation.org/packages/CAST/versions/0.5.1/topics/CreateSpacetimeFolds) cross-validation. For this we use the function CreateSpacetimeFolds from the R package [CAST]( https://cran.r-project.org/web/packages/CAST/CAST.pdf).  

To perform a spatial variable selection, we will use another function from the same package, a [Forward-Feature-Selection (FFS)](https://www.rdocumentation.org/packages/CAST/versions/0.2.0/topics/ffs). 

Familiarize yourself with the topics by reading the corresponding article.

## Video
Placeholder, for now:

{% include pdf pdf="GeoAI-03-01_Intro.pdf" %}


## Unit 3 slides

{% include pdf pdf="GeoAI-Unit03.pdf" %}


## Further reading
[Meyer H, Reudenbach C, Hengl T, Katurji M, Nauss T (2018) Improving performance of spatio-temporal machine learning models using forward feature selection and target-oriented validation. Environmental Modelling & Software 101: 1–9. https://doi.org/10.1016/j.envsoft.2017.12.001.](https://www.sciencedirect.com/science/article/abs/pii/S1364815217310976)


## Still Questions?
We highly recommend the following talk, which addresses the issues in more detail:

* [Hanna Meyer: "Machine-learning based modelling of spatial and spatio-temporal data"(53:24)](https://www.youtube.com/watch?v=QGjdS1igq78&t=2676s)