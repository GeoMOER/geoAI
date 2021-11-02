--- 
title: EX | Warm Up R-spatial
toc: true
header:
  image: /assets/images/01-splash.jpg
  image_description: "Dr. John Snow's map"
  caption: "Map: [**Dr. John Snow**](https://en.wikipedia.org/wiki/John_Snow) [Wellcome Library via wikimedia](https://w.wiki/QtV)"
---

`R` is a very powerful software tool with many functions. In this course, we are interested in using `R` to analyze spatial data and create maps based on it.
<!--more-->


## Assignment
The first exercise in this unit is pragmatic and deals with preparing and handling the aerial photo data used for the rest of the course.

In the remainder of this course, we will classify or "predict" the location of buildings from this data with the help of suitable models. For this purpose, several types of data are necessary. Furthermore, this data has to be converted into a specific form for technical and organizational reasons.

The following script snippets show how the data should be organized and which tools to use. 

In detail, we will perform the following tasks:
1. download the prepared data from the course server
1. prepare the grid and vector data 
1. visualize the data
1. calculate some indices
1. save the results


### Step 1 - Get the data and setup the working environment
The Hessian State Department of Land Management and Geoinformation ([Hessische Verwaltung fuer Bodenmanagement und Geoinformation; HVBG](https://hvbg.hessen.de/)) commissions flights for the entire state of Hesse every 2 years. They make the imagery, known as digital orthophotos (DOPs), available in 20cm and 40cm resolution with 4 channels: Red (R), Green (G), Blue (B) and Near-Infrared (NIR). More information about the HVBG's DOPs is available [here](https://hvbg.hessen.de/geoinformation/landesvermessung/geotopographie/luftbilder/digitale-orthophotos-atkis%C2%AE-dops-und-true) (German only). 

The 20-cm DOP of our study area is available for  [download](http://85.214.102.111/geo_data/data/01_raw_data/aerial/) from the course server. Please note that the HVBG has provided these DOPs free of charge for the purpose of education and that they may only be used in the context of this course.


**Writing it down as a script** 
Remember. We start **every single script** by reading our script `geoAI_setup.R`, from Unit 1. 
Then we start the actual work:
* First, we import a digital orthophoto of Marburg. To import so-called raster data, we normally use the package `raster`, which is loaded with the call `library(raster)`. We don't need to do this, however, because we already loaded the package via the setup script. 
* Next, we import a vector data set containing the areas of the buildings. 
* Then, we check the georeferencing.
* Finally, we visualize the data
{: .notice--info}

### Step 2 - Prepare the data
After downloading the data, move them into the `data` path of our working environment. 
We will start by creating a new `R` script called `data.R` in the `src` folder.


#### Raster Data

<script src="https://gist.github.com/gisma/de8351de7183737d5eb77bf7ed4d2b83.js"></script>

```bash
https://gist.github.com/de8351de7183737d5eb77bf7ed4d2b83.git
```

Specifically, we use the `stack` function from the `raster` package to import the TIF file here. By using the `::` syntax, i.e. `package::function`, we guarantee that we are using a specific function from a specific package. This concept is important to ensure that we are using the correct function (because some packages use the same function names, which is called masking).

#### Vector Data
In addition to raster data, `R` can handle vector data as well. A different package, `sf`, is required to read vector data of many types. Here, we use the function `read_sf` to import the buildings polygons into `R`. 
For training purposes we will download some data from the Openstreetmap (OSM) data base. For an overview of the availabele [feature](https://wiki.openstreetmap.org/wiki/Map_features) have a loook at the website. 

```r
# Example Polygons
# OSM public data orchards marburg
# do not forget to add the osmdata package to your header section of the script

library(osmdata)
# loading OSM data for the Marburg region with the landuse "orchard"
orchard = opq(bbox = "marburg de") %>% 
    add_osm_feature(key = "landuse", value = c("orchard")) %>% 
    osmdata_sf()
mapview::mapview(orchard$osm_polygons,zcol="produce")
```


#### Coordinate Reference System
Geospatial data always needs a [coordinate reference system (CRS)](https://en.wikipedia.org/wiki/Spatial_reference_system). In `R`, you can check the CRS of an imported layer using the `crs` function in the `raster` package.

```r
# 2 - check CRS and other info
#-----------------------#
raster::crs(rasterStack)
raster::crs(buildings)
```
Both of these layers should return the same CRS. In cases when you are uncertain if two layers have the same CRS, you can use a logical query to test if they are the same.

```r
crs(rasterStack) == crs(buildings)
```
If these layers have the same CRS, this command will return `TRUE`. Otherwise, `R` will return `FALSE`. Queries like this can be useful for more complex geospatial data workflows, e.g. if two layers have the same CRS, then continue with the analysis, otherwise stop.

### Step 3 - Visualize the data
Now that we have the DOP imported into `R`, we want to see what it looks like. There are many options for visualizing geospatial data in `R`, whether it be raster or vector data, with options ranging from basic static plots, e.g. `plotRGB` to interactive plots, e.g. `mapview`.

```r
# 3 - visualize the data ####
#-----------------------#
# simple RGB plot
raster::plotRGB(rasterStack)

# interactive plot
mapview(rasterStack)
```
**Additional Resources** 
Many packages and functions have been written to visualize geospatial data in `R`. In fact, there are too many to mention here. If you're interested, [Chapter 1.5](https://geocompr.robinlovelace.net/intro.html#the-history-of-r-spatial) of [Geocomputation with R](https://geocompr.robinlovelace.net/index.html) by Lovelace, Nowosad & Muenchow provides a concise history of the packages developed by the `R` spatial community. 
{: .notice--info}

### Step 4 - Calculate RGB indices
Visualizing spatial data is fantastic and makes sense -- we want to make maps after all -- but conventional GIS software can do this with raster and vector data as well. One way in which `R` adds value as a GIS is in the statistical analyses that you can do with raster data. For example, we can use the different spectral bands of an image to calculate so-called indices. One of the most widely known indices created used remote sensing data is the [Normalized difference vegetation index (NDVI)](https://en.wikipedia.org/wiki/Normalized_difference_vegetation_index). NDVI is useful for distinguishing live green vegetation, because of its properties in the near-infrared and red wavelengths. Due to these spectral properties, NDVI requires more than the three standard RGB channels and is calculated using the Near Infrared and Red channels of an image as follows:

<div align="center">
 <img width="50%" src="../assets/images/unit02/NDVI.svg">
 <figure >  
  <figcaption class="figure-caption text-start">The equation of calculating the NDVI. For more information, check out [Earth Lab](https://www.earthdatascience.org/courses/earth-analytics/multispectral-remote-sensing-data/vegetation-indices-NDVI-in-R/)
  </figcaption>
 </figure>
</div>


```r
# 4 - calculate RGB indices ####
# We can use raster as simple calculator
# First, we assign the three first layers in the raster image to variables
# called - surprise - red, green and blue (this is to keep it simple and clear)
#-----------------------#
red   <- rasterStack[[1]]
green <- rasterStack[[2]]
blue  <- rasterStack[[3]]

# Then we calculate all of the indices we need or want

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
**Further Reading** There are plenty of remote sensing indices that can be calculated from simple RGB imagery as well -- take a look [here](https://www.indexdatabase.de/db/i.php) for some ideas.

**Hint:** For those interested in doing less typing and learning more about R package development and maintenance, the `uavRst` [package](https://github.com/gisma/uavRst) contains these three and many more RGB indices in one simple function. The challenge is to get all the features of the package working, since it accesses the command line interfaces of SAGA, GRASS, and Orfeo toolbox. If you're keen to challenge yourself -- good luck!


{% gist 65b54a38e078ec0e0e8ceca1c460c950 %}
[Get snippet](https://gist.github.com/envimar/65b54a38e078ec0e0e8ceca1c460c950/archive/82dea04aa4bcdf97b347b1feb9edd4b9d5e34109.zip)

{% endcapture %}
<div class="notice--info">
  {{ Hint | markdownify }}
</div> 

### Step 5 - Save the results for later usage
Finally, now that we have calculated some remote sensing indices that will be necessary for our machine learning prediction later on, it would be useful and time-efficient to only have to calculate them once (not every time that we open an `R` session). RDS is ideal for this purpose, because it allows us to save a single `R` object to a file and restore it. Please note that `saveRDS`is highly efficient for saving a **single** `R` object only.

```r
# 5 - stack and save as RDS ####
#-----------------------#
marburg_stack <- stack(rasterStack, rgbI)

saveRDS(marburg_stack, (file.path(envrmt$data_processed, "dop_indices.rds"))
```

# Now repeat with Sentinel satellite data
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
### The `sen2r` GUI
The easiest way to use `sen2r` is to open the graphical user interface (GUI) and use it in interactive mode. However, here you have to choose from a large number of options in the settings. The knowledge required for this is also necessary for the command line version presented below. Both interfaces can be automated. We recommend the API, but ultimately it is up to you. To do so, use the function with the same name.

```r
sen2r:sen2r()
```
{% include figure image_path="/assets/images/unit01/sen2r.png" alt="sen2r GUI screenshot" caption="Sen2r GUI starting screen. You have to go through the options tab by tab. The selected configuration can be saved and also called as a script. Note that an account at [Copernicus SciHub](https://scihub.copernicus.eu/dhus/#/home) is mandatory." %}

### The `sen2r` API
In the following script Sentinel-2 data are used to calculate the surface albedo. For this the following steps are necessary:
1. set up the working environment (Attention: additional libraries will be loaded here)
2. download data by configuring and executing `sen2r` using the API
3. calculate the surface albedo (exemplary) 

{% gist 7b6eb9122522eb0797407ecf6cc5176b%}
[Get sentinel_albedo.R](https://gist.github.com/envimar/7b6eb9122522eb0797407ecf6cc5176b/archive/87e28a974913acd62653fef49041a7fdc422cc4a.zip)

The [sen2r vignette](https://sen2r.ranghetti.info/) offers plenty of helpful information about how to use the GUI as well as to access the functionality of `sen2r` from within `R`.


## Assignment Unit-1-2

Now that some basics have been explained, it's time to practice on your own. The following tasks serve as an orientation framework within which you can practice in a targeted manner. It requires you to solve some technical, content-related and conceptual problems. Let's go.

At Robert Hijmans' `raster` [homepage](https://rspatial.org/raster/index.html#) you will find a lot of straightfoward exercises, including our basic examples from before. Robert also provides the necessary data. Another highly recommend place is [Geocomputation with R](https://geocompr.robinlovelace.net) by Robin Lovelace, Jakub Nowosad and Jannes Muenchow. It is the outstanding reference and a perfect starting point for everything related to spatio-temporal data analysis and processing with `R`. 

A good approach to improve you skills is to dive in these kind of exercises and substitute the example data with your own data.
This means:
1. Do the exercises with the example data (technical base check)
1. Do the exercises with your own data  (advanced technical base check)
1. Understand the operation

It is a good habit to document what you learn (the knowledge you gain) and any open questions you may have as well as problems that arise. Documenting your progress in an `Rmarkdown` document is particularly useful for this purpose. The package `blogdown` is, in fact, excellent for this. The key is practice: not just getting sample source code to run, but changing it and understanding what it does. 
{: .notice--info}

Please do the following exercises using either the Marburg buildings or the Sentinel-2 dataset. 


{% capture Assignment-1-2 %}
1. Read and operate the following chapters: 
* [Geographic data in R](https://geocompr.robinlovelace.net/spatial-class.html)
* [Spatial data operations](https://geocompr.robinlovelace.net/spatial-operations.html#spatial-operations)
* [Spatial Operations](https://geocompr.robinlovelace.net/spatial-operations.html#spatial-operations)
2. Please visit Robert Hijmans' page about [unsupervised classification](https://rspatial.org/raster/rs/4-unsupclassification.html#unsupervised-classification). Follow his guideline, but instead use:
* the Sentinel-2 data 
* the Marburg buildings data

Put your results and your code (remember to use the course setup!) in an `Rmarkdown` file and `knitr` it to a pdf. Please upload this pdf to ILIAS.

Hint: If you need help with Rmarkdown have a look at[R Markdown Quick Tour
](https://rmarkdown.rstudio.com/authoring_quick_tour.html)
{: .notice--info}
{% endcapture %}
<div class="notice--success">
  {{ Assignment-1-2 | markdownify }}
</div> 


## Where can I find more information?
For more information, you can look at the following resources: 

* [Spatial Data Analysis](https://rspatial.org/raster/analysis/2-scale_distance.html) by Robert Hijmans. Very comprehensive and recommended. Many of the examples are based on his lecture and are adapted for our conditions.

* [Geocomputation with R](https://geocompr.robinlovelace.net) by Robin Lovelace, Jakub Nowosad, and Jannes Muenchow is the outstanding reference for everything related to spatiotemporal data analysis and processing with R. 



## Comments?
<script src="https://gist.github.com/Baldl/51fa03d0865bdf7ddd90a16276779582.js"></script>