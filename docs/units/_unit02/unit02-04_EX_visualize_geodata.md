---
title: EX | Visualizing geodata in R
toc: true
header:
  image: /assets/images/unit02/31031723265_0890cd9547_o.jpg
  image_description: "Cloudscape Over the Philippine Sea"
  caption: "Image: [NASA's Marshall Space Flight Center](https://www.nasa.gov/centers/marshall/home/index.html) [CC BY-NC 2.0] via [flickr.com](https://www.flickr.com/photos/nasamarshall/31031723265/)"
---


<!--more-->

## Background
R is a very powerful software tool with many functions. In this course, we are interested in using R to analyze spatial data and create maps based on it.

### Digital Orthophotos
First, the DOPs. Digital [orthophotos](https://en.wikipedia.org/wiki/Orthophoto) are images taken from either satellites or aerial photography that have been corrected using a [digital surface model (DSM)](https://en.wikipedia.org/wiki/Digital_elevation_model#Terminology). The correction process, called [orthorectification](https://www.dlr.de/eoc/en/desktopdefault.aspx/tabid-6144/10056_read-20918/), is necessary for removing sensor, satellite/aircraft motion and terrain-related geometric distortions from raw imagery. This step is one of the main processing steps in evaluating remote sensing data, as it produces a true-to-scale photographic map.

### Digitize training areas
Training areas are the basis of supervised classification. Creating training areas allows us, the user, to tell the computer what we see in an image. It transfers the knowledge that we have about individual objects in an image to a digital level. Once we have enough training areas, we can feed them into a machine learning algorithms to classify the remaining pixels of an image. This process is called supervised classification.

A supervised land-cover classification uses a limited set of labeled training data to derive a model, which predicts the respective land-cover in the entire dataset. Hence, the land-cover types are defined *a priori* and the model tries to predict these types based on the similiarity between the properties of the training data and the rest of the dataset.

{% include figure image_path="/assets/images/spotlight01/supervised_classification.jpg" alt="Illustration of a supervised classification." %}

Such classifications generally require at least five steps:
1. Compiling a comprehensive input dataset containing one or more raster layers.
1. Selecting training areas, i.e. subsets of input datasets for which the remote sensing expert knows the land-cover type. Knowledge about the land cover can be derived e.g. from own or third party *in situ* observations, management information or other remote sensing products (e.g. high-resolution aerial images).
1. Training a model using the training areas. For validation purposes, the training areas are often further divided into one or more test and training samples to evaluate the performance of the model algorithm.
1. Applying the trained model to the entire dataset, i.e. predicting the land-cover type based on the similarity of the data at each location to the class properties of the training dataset.

Please note that all types of classifications require a thorough validation, which will be in the focus of upcoming course units.
{: .notice--info} 

The following illustration shows the steps of a supervised classification in more detail. The optional segmentation operations are mandatory for object-oriented classifications, which rely on the values of each individual raster cell in the input dataset in addition to considering the geometry of objects. To delineate individual objects, such as houses or tree crowns, remote sensing experts use segmentation algorithms, which consider the homogeneity of the pixel values within their spatial neighborhood. 

{% include figure image_path="/assets/images/spotlight01/supervised_classification_concept.jpg" alt="Illustration of a supervised classification." %}


## Assignment
This first exercise will prepare the data that is necessary to predict **Streuobstwiese** in Hesse with a random forest model. Please run the following R code and upload the output to the course website. Remember to use the folder structure that we set up in Unit 1!

## Get data
The Hessian State Department of Land Management and Geoinformation ([Hessische Verwaltung fuer Bodenmanagement und Geoinformation; HVBG](https://hvbg.hessen.de/)) uses an image-based DSM to create what they call "TrueDOPs". The HVBG commissions flights for the entire state of Hesse every 2 years and makes the imagery available in 20cm and 40cm resolution with 4 channels: Red (R), Green (G), Blue (B) and Near-Infrared (NIR). More information about the HVBG's TrueDOPs is available [here](https://hvbg.hessen.de/geoinformation/landesvermessung/geotopographie/luftbilder/digitale-orthophotos-atkis%C2%AE-dops-und-true) (German only). The 40-cm DOPs of our study area are available for download **[here]**.
{: .notice--info}


### Creating vector layers in QGIS

QGIS is an open source GIS.

## Import data in R
Explanation of code block 1 here
```r
THIS IS DUMMY CODE
# 1 - import the data ####
#-----------------------#

rasterStack = raster::stack(file.path(envrmt$sentinel, "sentinel.tif"))
# Polygons:
pol = sf::read_sf(file.path(envrmt$hlnug, "streuobst.gpkg"))

```
Show output of R code block 1 here

Further explanation of code block 1, plus transition to code block 2 here

```r
THIS IS DUMMY CODE
# 2 - do something with data ####
#-----------------------#

rasterStack = raster::stack(file.path(envrmt$sentinel, "sentinel.tif"))
# Polygons:
pol = sf::read_sf(file.path(envrmt$hlnug, "streuobst.gpkg"))

```
Show output of R code block 2 here

Further explanation of code block 2, plus transition to code block 3 here

```r
THIS IS DUMMY CODE
# 3 - save as RDS ####
#-----------------------#

rasterStack = raster::stack(file.path(envrmt$sentinel, "sentinel.tif"))
# Polygons:
pol = sf::read_sf(file.path(envrmt$hlnug, "streuobst.gpkg"))

```
Show output of R code block 3 here
