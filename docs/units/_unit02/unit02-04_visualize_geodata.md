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

## Assignment
This first exercise will prepare the data that is necessary to predict **Streuobstwiese** in Hesse with a random forest model. Please run the following R code to create a stack of different rasters that we will use to train our random forest model. Remember to use the folder structure that we set up in Unit 1!

### Get data
The Hessian State Department of Land Management and Geoinformation ([Hessische Verwaltung fuer Bodenmanagement und Geoinformation; HVBG](https://hvbg.hessen.de/)) uses an image-based DSM *to create what they call "TrueDOPs"*. The HVBG commissions flights for the entire state of Hesse every 2 years and makes the imagery available in 20cm and 40cm resolution with 4 channels: Red (R), Green (G), Blue (B) and Near-Infrared (NIR). More information about the *HVBG's TrueDOPs* is available [here](https://hvbg.hessen.de/geoinformation/landesvermessung/geotopographie/luftbilder/digitale-orthophotos-atkis%C2%AE-dops-und-true) (German only). 

The 40-cm DOP of our study area is available for download [here](http://85.214.102.111/geo_data/data/01_raw_data/aerial/). Please note that the HVBG has provided these digital orthophotos free of charge for the purpose of education and that they may only be used in the context of this course.
{: .notice--info}

### Import data in R
First, we start by sourcing our `geoAI_setup.R` script that we created in Unit 1. Then, we import a digital orthophoto of Marburg. To do this, we use the `raster` package. We do not need to load the `raster` package with a call to `library(raster)` because our set up script already loaded it.

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

### Visualize the data
Now that we have the DOP imported into R, we want to see what it looks like. There are many options for visualizing geospatial data in R, whether it be raster or vector data, with options ranging from basic static plots, e.g. `plotRGB` to interactive plots, e.g. `mapview`.

```r
# 3 - visualize the data ####
#-----------------------#
# simple RGB plot
raster::plotRGB(rasterStack)

# interactive plot
mapview(rasterStack)
```
Many packages and functions have been written to visualize geospatial data in R. In fact, there are too many to mention here. If you're interested, [Chapter 1.5](https://geocompr.robinlovelace.net/intro.html#the-history-of-r-spatial) of [Geocomputation with R](https://geocompr.robinlovelace.net/index.html) by Lovelace, Nowosad & Muenchow provides a concise history of the packages developed by the R spatial community. 

### Calculate RGB indices
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

For those interested in doing less typing and learning more about R package development and maintenance, the `uavRst` [package](https://github.com/gisma/uavRst) contains these three and many more RGB indices in one simple function. The challenge is in getting the package to work. If you're keen to challenge yourself -- good luck!

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

### Save for later
Finally, now that we have calculated some remote sensing indices that will be necessary for our machine learning prediction later on, it would be useful and time-efficient to only have to calculate them once (not every time that we open an R session). RDS is ideal for this purpose, because it allows us to save a single R object to a file and restore it.

```r
# 5 - stack and save as RDS ####
#-----------------------#
marburg_stack <- stack(rasterStack, rgbI)

saveRDS(marburg_stack, (file.path(envrmt$data_processed, "dop_indices.rds"))
```
## Now doing the same with Sentinel data
Working with high-resolution aerial imagery is certainly nice, but also has its downsides. It is expensive to generate or procure, it often only covers relatively small areas and it is not always readily available. Satellite data, on the other hand, is continuously available and made readily accessible. One example of such satellite data that is often used in environmental remote sensing is the [Sentinel-2 mission](https://sentinel.esa.int/web/sentinel/missions/sentinel-2) by the European Space Agency.

The package `sen2r` allows you to download and preprocess Sentinel-2 images directly into `R`.

{% capture Installation-Help %}

To install `sen2r` you need to have `Rtools` installed.

1. Go to [http://cran.r-project.org/bin/windows/Rtools/](http://cran.r-project.org/bin/windows/Rtools/) 
1. Select the download link that corresponds to your version of `R`
1. Open the .exe file and use the default settings
1. **Make sure to check the box for the installer to edit your PATH**
1. Run `library(devtools)` in `R`
1. Run `find_rtools()` -- if `TRUE` the installation worked properly
{% endcapture %}
<div class="notice--success">
  {{ Installation-Help | markdownify }}
</div> 

Then it is a matter of simply installing the package as we would with any other package.

```r
install.packages("sen2r")
library(sen2r)
```

The easiest way to use `sen2r` is to open the GUI and use it in interactive mode. Do this by using the function of the same name.

```r
sen2r:sen2r()
```
However if you have a look at the interface you will notice that on the one hand you have a GUI  but on the other hand it is highly complex...
So let's do it with a script following the guideline.


```r
#------------------------------------------------------------------------------
# Type: script
# Name: sentinel_albedo.R
# Author: Chris Reudenbach, creuden@gmail.com
# Description:  retrieves sentinel data 
#               and exemplary defines AOI and calculates albedo
# Dependencies: geoAI.R  
# Output: original sentinel tile 
#         AOI window of this tile (research_area)
#         top of atmosphere albedo AOI
#         surface albedo AOI
# Copyright: Chris Reudenbach 2021, GPL (>= 3)
# git clone https://github.com/gisma-courses/courses-scripts/get-sentinel.git
#------------------------------------------------------------------------------

# 0 - specific setup
#-----------------------------
library(envimaR)
appendpackagesToLoad = c("rprojroot","sen2R","terra")

# add define project specific subfolders
appendProjectDirList = c("data/sentinel/",
                         "data/vector_data/",
                         "data/sentinel/S2/",
                         "data/sentinel/SAFE/",
                         "data/sentinel/research_area/")

source(file.path(envimaR::alternativeEnvi(root_folder = "~/edu/geoAI",
                                          alt_env_id = "COMPUTERNAME",
                                          alt_env_value = "PCRZP",
                                          alt_env_root_folder = "F:/BEN/edu"),
                 "src/geoAI_setup.R"))

# 2 - define variables
#---------------------
# define area by an existing vector data set using sf
myextent  = sf::st_read(file.path(envrmt$path_data,"/vector_data/trainingSites.shp"))

# setup sentinel retrieval object
out_paths_1 <- sen2r::sen2r(
  gui = FALSE,
  step_atmcorr = "l2a",
  online = FALSE,
  extent = myextent,
  extent_name = "MOF",
  timewindow = c(as.Date("2021-06-12"), as.Date("2021-06-14")),
  list_prods = c("BOA","SCL"),
  list_indices = c("NDVI","MSAVI2"),
  list_rgb = c("RGB432B"),
  mask_type = "cloud_and_shadow",
  max_mask = 10,
  path_l2a = envrmt$path_SAFE, # folder to store downloaded SAFE
  server = "scihub",
  preprocess = TRUE,
  parallel = TRUE,
  sen2cor_use_dem = TRUE,
  max_cloud_safe = 10,
  overwrite = TRUE,
  path_out =  envrmt$path_research_area # folder to store downloaded research arec cutoff
)

# subsetting the filename(s) of the interesting file(s)
fn_noext=xfun::sans_ext(basename(list.files(paste0(envrmt$path_research_area,"/BOA/"),pattern = "S2B2A")))
fn = basename(list.files(paste0(envrmt$path_research_area,"/BOA/"),pattern = "S2B2A"))

# creating a raster stack
stack=raster::stack(paste0(envrmt$path_research_area,"/BOA/",fn))

# now  simply calculate the surface albedo following an approch provided
# an adapted regression function of the package 'agriwater'

b2 <- stack[[2]]/10000
b3 <- stack[[3]]/10000
b4 <- stack[[4]]/10000
b8 <- stack[[8]]/10000

alb_top = b2 * 0.32 + b3 * 0.26 + b4 * 0.25 + b8 * 0.17
alb_surface = 0.6054 * alb_top + 0.0797

plot(alb_top)
plot(alb_surface)

```

The [sen2r vignette](https://sen2r.ranghetti.info/) offers plenty of helpful information about how to use the GUI as well as to access the functionality of `sen2r` from within `R`.
