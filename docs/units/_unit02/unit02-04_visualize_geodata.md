---
title: EX | In a nutshell - remote sensing with R  
toc: true
header:
  image: /assets/images/unit02/31031723265_0890cd9547_o.jpg
  image_description: "Cloudscape Over the Philippine Sea"
  caption: "Image: [NASA's Marshall Space Flight Center](https://www.nasa.gov/centers/marshall/home/index.html) [CC BY-NC 2.0] via [flickr.com](https://www.flickr.com/photos/nasamarshall/31031723265/)"
---

R is a very powerful software tool with many functions. In this course, we are interested in using R to analyze spatial data and create maps based on it.
<!--more-->


## Assignment
The first exercise in this unit deals pragmatically with the preparation and handling of the aerial photo data used for the rest of the course.

In the further course, meadow orchards are to be classified or "predicted" from these data with the help of suitable models. For this purpose, a number of data are necessary. Furthermore, these data have to be converted into a specific form for technical and organizational reasons.

In the following script snippets it is shown with which tools and in which way the data should be organized. 

In detail, the following tasks have to be performed:
1. download the prepared data from the course server.
2. prepare the grid and vector data 
3. Visualize the data
5. Calculate some indices



### The data
The Hessian State Department of Land Management and Geoinformation ([Hessische Verwaltung fuer Bodenmanagement und Geoinformation; HVBG](https://hvbg.hessen.de/)) uses an image-based DSM *to create what they call "TrueDOPs"*. The HVBG commissions flights for the entire state of Hesse every 2 years and makes the imagery available in 20cm and 40cm resolution with 4 channels: Red (R), Green (G), Blue (B) and Near-Infrared (NIR). More information about the *HVBG's TrueDOPs* is available [here](https://hvbg.hessen.de/geoinformation/landesvermessung/geotopographie/luftbilder/digitale-orthophotos-atkis%C2%AE-dops-und-true) (German only). 


**Get the data**
The 40-cm DOP of our study area is available for [download](http://85.214.102.111/geo_data/data/01_raw_data/aerial/). Please note that the HVBG has provided these digital orthophotos free of charge for the purpose of education and that they may only be used in the context of this course.
{: .notice--info}

### Writing it down as a script
Remember. We start **every single script** by reading our script "geoAI_setup.R", from unit 1. 
Then we start the actual work :
* We import a digital orthophoto of Marburg.  To import so called raster data we normally use the package `raster` which is loaded with the call `library(raster)`. We don`t need to do this, because we already loaded it via the setup script. 
* Then we import a vector data set containing the areas of the orchards as polygons. 
* Then we check the georeferencing.
* and visualize the data


### Step 1 - Import data in R
After Downloading the data you have to move them in the `data` path of our working environment. 
We will start by creating a new R-script in the `src` Folder that we call `data.R`.


#### Raster Data
```r
# 1 - source setup function & import the data 
#-----------------------#
source(file.path(envimaR::alternativeEnvi(root_folder = "~/edu/geoAI",
                                       alt_env_id = "COMPUTERNAME",
                                       alt_env_value = "PCRZP",
                                       alt_env_root_folder = "F:/BEN/edu"),
                 "src/geoAI_setup.R"))

# Read DOP as a raster stack 
# Note you need the commands stack or brick to create a pile of all single raster
# layer in an image. with the common command raster you read only the first band
rasterStack = raster::stack(file.path(envrmt$data, "marburg_dop.tif"))
```
Specifically, we use the `stack` function from the `raster` package to import the TIF file here. By using the `::` syntax, i.e. `package::function`, we guarantee that we are using a specific function from a specific package. This concept is important to ensure that we are using the correct function (because some packages use the same function names, which is called masking).

#### Vector Data
In QGIS, we created the **Streuobstwiese** polygons and exported them as a [GeoPackage](https://en.wikipedia.org/wiki/GeoPackage) (.gpkg). The GeoPackage format has several advantages compared to previous formats for saving and exchanging geospatial data. For example, it supports both raster and vector data and it is saved in one file (unlike e.g. [shapefiles](https://en.wikipedia.org/wiki/Shapefile)).

R can also handle vector data as well. A different package, `sf`, is required to read vector data of many types. Here, we use the function `read_sf` to import the **Streuobstwiese** polygons into R. 

```r
# Polygons, too:
orchard = sf::read_sf(file.path(envrmt$data, "streuobst.gpkg"))
```
#### Coordinate Reference System
Geospatial data always needs a [coordinate reference system (CRS)](https://en.wikipedia.org/wiki/Spatial_reference_system). When we created the training areas in QGIS, we assigned the polygons in the GeoPackage the same CRS as the DOP, because they are part of the same project. In R, you can check the CRS of an imported layer using the `crs` function in the `raster` package.

```r
# 2 - check CRS and other info
#-----------------------#
raster::crs(rasterStack)
raster::crs(orchard)
```
As we assigned the CRS of the polygons using the DOP, we know that both of these layers will return the same CRS. In cases when you are uncertain if two layers have the same CRS, you can use a logical query to test if they are the same.

```r
crs(rasterStack) == crs(orchard)
```
If these layers have the same CRS, this command will return `TRUE`. Otherwise, R will return `FALSE`. Queries like this can be useful for more complex geospatial data workflows, e.g. if two layers have the same CRS, then continue with the analysis, otherwise stop.

#### Visualize the data
Now that we have the DOP imported into R, we want to see what it looks like. There are many options for visualizing geospatial data in R, whether it be raster or vector data, with options ranging from basic static plots, e.g. `plotRGB` to interactive plots, e.g. `mapview`.

```r
# 3 - visualize the data ####
#-----------------------#
# simple RGB plot
raster::plotRGB(rasterStack)

# interactive plot
mapview(rasterStack)
```
#### Further Readings
Many packages and functions have been written to visualize geospatial data in R. In fact, there are too many to mention here. If you're interested, [Chapter 1.5](https://geocompr.robinlovelace.net/intro.html#the-history-of-r-spatial) of [Geocomputation with R](https://geocompr.robinlovelace.net/index.html) by Lovelace, Nowosad & Muenchow provides a concise history of the packages developed by the R spatial community. 

### Step 2 - Calculate RGB indices
Visualizing spatial data is fantastic and makes sense -- we want to make maps after all -- but conventional GIS software can do this with raster and vector data as well. One way in which R adds value as a GIS is in the statistical analyses that you can do with raster data. For example, we can use the different spectral bands of an image to calculate so-called indices. One of the most widely known indices created used remote sensing data is the [Normalized difference vegetation index (NDVI)](https://en.wikipedia.org/wiki/Normalized_difference_vegetation_index), which is useful for distinguishing live green vegetation, because of its properties in the near-infrared and red wavelengths. Due to these spectral properties, NDVI requires more than the three standard RGB channels and is calculated using the Near Infrared and Red channels of an image as follows:

<div align="center">
 <img width="50%" src="../assets/images/unit02/NDVI.svg">
 <figure >  
  <figcaption align = "left"q>The equation of calculating the NDVI. For more Information have a look at  [Earth Lab](https://www.earthdatascience.org/courses/earth-analytics/multispectral-remote-sensing-data/vegetation-indices-NDVI-in-R/)
  </figcaption>
 </figure>
</div>


But there are plenty of remote sensing indices that can be calculated from simple RGB imagery as well -- take a look [here](https://www.indexdatabase.de/db/i.php) for some ideas. 

```r
# 4 - calculate RGB indices ####
# we can use raster as simple calculator
# first we assign the three first layers in the raster image to variables
# called - surpris - red, green, blue (this is to keep it simple and clear)
#-----------------------#
red   <- rasterStack[[1]]
green <- rasterStack[[2]]
blue  <- rasterStack[[3]]

# Then we calculate  all indices we need or want

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

{% capture Hint %}
**Hint:** For those interested in doing less typing and learning more about R package development and maintenance, the `uavRst` [package](https://github.com/gisma/uavRst) contains these three and many more RGB indices in one simple function. The challenge is to get all the features of the package working, since it accesses the command line interfaces of SAGA, GRASS, and Orfeo toolbox. If you're keen to challenge yourself -- good luck!


{% gist 65b54a38e078ec0e0e8ceca1c460c950 %}
[Get snippet](https://gist.github.com/envimar/65b54a38e078ec0e0e8ceca1c460c950/archive/82dea04aa4bcdf97b347b1feb9edd4b9d5e34109.zip)

{% endcapture %}
<div class="notice--info">
  {{ Hint | markdownify }}
</div> 

### Save the results for later usage
Finally, now that we have calculated some remote sensing indices that will be necessary for our machine learning prediction later on, it would be useful and time-efficient to only have to calculate them once (not every time that we open an R session). RDS is ideal for this purpose, because it allows us to save a single R object to a file and restore it. Please note that `saveRDS`is highly efficient to save a **single** R-object only.

```r
# 5 - stack and save as RDS ####
#-----------------------#
marburg_stack <- stack(rasterStack, rgbI)

saveRDS(marburg_stack, (file.path(envrmt$data_processed, "dop_indices.rds"))
```
# Now let us do it the same way with Sentinel satellite data
Working with high-resolution aerial imagery is certainly nice, but also has its downsides. It is expensive to generate or procure, it often only covers relatively small areas and it is not always readily available. Satellite data, on the other hand, is continuously available and made readily accessible. One example of such satellite data that is often used in environmental remote sensing is the [Sentinel-2 mission](https://sentinel.esa.int/web/sentinel/missions/sentinel-2) by the European Space Agency.

### The package `sen2r` 
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
<div class="notice--info">
  {{ Installation-Help | markdownify }}
</div> 

Then it is a matter of simply installing the package as we would with any other package.

```r
install.packages("sen2r")
library(sen2r)
```
### The sen2r GUI
First of all, the easiest way to use `sen2r` is to open the graphical user interface and use it in interactive mode. However, here you have to choose from a large number of setting options. The knowledge required for this is also necessary for the command line version presented below. You can automate both interfaces. We recommend the API but it is up to you.  Use the function with the same name.me.

```r
sen2r:sen2r()
```
{% include figure image_path="/assets/images/unit01/sen2r.png" alt="sen2r GUI screenshot" caption="Sen2r GUI starting screen. You have to go through the options tab by tab. The selected configuration can be saved and also called as a script. Attention, an account at [Copernicus SciHub](https://scihub.copernicus.eu/dhus/#/home) is mandatory.." %}

### The sen2r API
In the following script Sentinel data are used to calculate the surface albedo. For this the following steps are necessary:
1. set up the working environment (Attention: additional biliotheques etc. will be loaded here)
2. data download - for this `sent2r` is configured and executed to use the API
3. after the download the surface albedo is calculated (exemplary) 

{% gist 7b6eb9122522eb0797407ecf6cc5176b%}
[Get sentinel_albedo.R](https://gist.github.com/envimar/7b6eb9122522eb0797407ecf6cc5176b/archive/87e28a974913acd62653fef49041a7fdc422cc4a.zip)

The [sen2r vignette](https://sen2r.ranghetti.info/) offers plenty of helpful information about how to use the GUI as well as to access the functionality of `sen2r` from within `R`.

## Exercises

## Further Readings