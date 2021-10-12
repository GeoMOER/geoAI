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
The Hessian State Department of Land Management and Geoinformation ([Hessische Verwaltung fuer Bodenmanagement und Geoinformation; HVBG](https://hvbg.hessen.de/)) uses an image-based DSM *to create what they call "TrueDOPs"*. The HVBG commissions flights for the entire state of Hesse every 2 years and makes the imagery available in 20cm and 40cm resolution with 4 channels: Red (R), Green (G), Blue (B) and Near-Infrared (NIR). More information about the *HVBG's TrueDOPs* is available [here](https://hvbg.hessen.de/geoinformation/landesvermessung/geotopographie/luftbilder/digitale-orthophotos-atkis%C2%AE-dops-und-true) (German only). 

The 40-cm DOPs of our study area are available for download **[here]**. Please note that the HVBG has provided these digital orthophotos free of charge for the purpose of education and that they may only be used in the context of this course.
{: .notice--info}


### Creating vector layers in QGIS
Next, we will use the open source GIS QGIS to create training areas for our **Streuobstwiese**.

## Import data in R
First, we start by sourcing our set up script that we created in Unit 1. Then, we import a digital orthophoto of Marburg. To do this, we use the `raster` package. We do not need to load the `raster` package with a call to `library(raster)` because our set up script already loaded it.

```r
# 1 - source setup function & import the data ####
#-----------------------#
source(file.path(envimaR::alternativeEnvi(root_folder = "~/edu/geoAI",
                                       alt_env_id = "COMPUTERNAME",
                                       alt_env_value = "PCRZP",
                                       alt_env_root_folder = "F:/BEN/edu"),
                 "src/geoAI_setup.R"))

# Read DOP
rasterStack = raster::stack(file.path(envrmt$data, "marburg_dop.tif"))
```
Specifically, we use the `stack` function from the `raster` package to import the TIF file here. By using the `::` syntax, i.e. `package::function`, we guarantee that we are using a specific function from a specific package. This concept is important to ensure that we are using the correct function (because some packages use the same function names, which is called masking).

R can also handle vector data as well. A different package, `sf`, is required to read vector data of many types. Here, we use the function `read_sf` to import the **Streuobstwiese** polygons into R. 

```r
# Polygons, too:
pol = sf::read_sf(file.path(envrmt$data, "streuobst.gpkg"))
```
In QGIS, we created the **Streuobstwiese** polygons and exported them as a [GeoPackage](https://en.wikipedia.org/wiki/GeoPackage) (.gpkg). The GeoPackage format has several advantages compared to previous formats for saving and exchanging geospatial data. For example, it supports both raster and vector data and it is saved in one file (unlike e.g. [shapefiles](https://en.wikipedia.org/wiki/Shapefile)).

Geospatial data always needs a [coordinate reference system (CRS)](https://en.wikipedia.org/wiki/Spatial_reference_system). When we created the training areas in QGIS, we assigned the polygons in the GeoPackage the same CRS as the DOP, because they are part of the same project. In R, you can check the CRS of an imported layer using the `crs` function in the `raster` package.

```r
# 2 - check CRS and other info
#-----------------------#
raster::crs(rasterStack)
raster::crs(pol)
```
As we assigned the CRS of the polygons using the DOP, we know that both of these layers will return the same CRS. In cases when you are uncertain if two layers have the same CRS, you can use a logical query to test if they are the same.

```r
crs(rasterStack) == crs(pol)
```
If these layers have the same CRS, this command will return `TRUE`. Otherwise, R will return `FALSE`. Queries like this can be useful for more complex geospatial data workflows, e.g. if two layers have the same CRS, then continue with the analysis, otherwise stop.


Now that we have the DOP imported into R, we want to see what it looks like. There are many options for visualizing geospatial data in R, whether it be raster or vector data, with options ranging from basic static plots, e.g. `plotRGB` to interactive plots, e.g. `mapview`.

```r
# 3 - visualize the data ####
#-----------------------#
# simple RGB plot
raster::plotRGB(rasterStack)

# interactive plot
library(mapview)
mapview(rasterStack)
```
Many packages and functions have been written to visualize geospatial data in R. In fact, there are too many to mention here. If you're interested, [Chapter 1.5](https://geocompr.robinlovelace.net/intro.html#the-history-of-r-spatial) of [Geocomputation with R](https://geocompr.robinlovelace.net/index.html) by Lovelace, Nowosad & Muenchow provides a concise history of the packages developed by the R spatial community. 

Visualizing spatial data is fantastic and makes sense -- we want to make maps after all -- but conventional GIS software can do this with raster and vector data as well. One way in which R adds value as a GIS is in the statistical analyses that you can do with raster data. For example, we can use the different spectral bands of an image to calculate so-called indices. One of the most widely known indices created used remote sensing data is the [Normalized difference vegetation index (NDVI)](https://en.wikipedia.org/wiki/Normalized_difference_vegetation_index), which is useful for distinguishing live green vegetation, because of its properties in the near-infrared and red wavelengths. Due to these spectral properties, NDVI requires more than the three standard RGB channels and is calculated using the Near Infrared and Red channels of an image as follows:

<p align="center">
  <img src="../assets/images/unit02/NDVI.svg">
</p>

But there are several remote sensing indices that can be calculated from simple RGB imagery as well -- take a look [here](https://www.indexdatabase.de/db/i.php) for some ideas. 

```r
# 4 - calculate RGB indices ####
#-----------------------#
red   <- rasterStack[[1]]
green <- rasterStack[[2]]
blue  <- rasterStack[[3]]

## Normalized difference turbidity index (NDTI)
NDTI <- (red - green) / (red + green)
names(NDTI) <- "NDTI"

## Visible Atmospherically Resistant Index (VARI)
VARI <- (green - red) / (green + red - blue)
names(VARI) <- "VARI"

## Triangular greenness index (TGI)
TGI <- -0.5*(190*(red - green)- 120*(red - blue))
names(TGI) <- "TGI"

rgbI <- raster::stack(NDTI, VARI, TGI)
raster::plot(rgbI)
```

For those interested in typing less and learning more about R package development and maintenance, the `uavRst` [package](https://github.com/gisma/uavRst) contains these and many more RGB indices in one simple function. The challenge is in getting the package to work -- good luck!

```r
# alternatively, use uavRst
library(uavRst)
rgbI <- rgb_indices(red = rasterStack[[1]], 
                    green = rasterStack[[2]], 
                    blue  = rasterStack[[3]], 
                    rgbi = c("NDTI","VARI","TGI"))
                  
# visualize these results
raster::plot(rgbI)
```
Finally, now that we have calculated some remote sensing indices that will be necessary for our machine learning prediction later on, it would be useful and time-efficient to only have to calculate them once (not every time that we open an R session).

```r
# 5 - stack and save as RDS ####
#-----------------------#
marburg_stack <- stack(rasterStack, rgbI)

saveRDS(marburg_stack, "dop.rds")
```
## sen2R
