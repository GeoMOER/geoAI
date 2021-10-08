---
title: EX | Import and prepare your data
toc: true
header:
  image: /assets/images/unit03/streuobst.jpg
  image_description: "Apples under tree"
  caption: "Image: manfredrichter via [pixabay.com](https://pixabay.com/de/photos/%C3%A4pfel-streuobst-obstbaum-apfelbaum-3684775/)"
  
--- 

This first exercise will prepare the data that is necessary to predict **Streuobstwiese** in Hesse with a random forest model. To train the model, we will use a selection of aerial photographs or digital orthophotos (DOP) and polygon data.

## Get data


### Digital Orthophotos

First, the DOPs. Digital [orthophotos](https://en.wikipedia.org/wiki/Orthophoto) are images taken from either satellites or aerial photography that have been corrected using a [digital surface model (DSM)](https://en.wikipedia.org/wiki/Digital_elevation_model#Terminology). The correction process, called [orthorectification](https://www.dlr.de/eoc/en/desktopdefault.aspx/tabid-6144/10056_read-20918/), is necessary for removing sensor, satellite/aircraft motion and terrain-related geometric distortions from raw imagery. This step is one of the main processing steps in evaluating remote sensing data, as it produces a true-to-scale photographic map.

The Hessian State Department of Land Management and Geoinformation ([Hessische Verwaltung fuer Bodenmanagement und Geoinformation; HVBG](https://hvbg.hessen.de/)) uses an image-based DSM to create what they call "TrueDOPs". The HVBG commissions flights for the entire state of Hesse every 2 years and makes the imagery available in 20cm and 40cm resolution with 4 channels: Red (R), Green (G), Blue (B) and Near-Infrared (NIR). More information about the HVBG's TrueDOPs is available [here](https://hvbg.hessen.de/geoinformation/landesvermessung/geotopographie/luftbilder/digitale-orthophotos-atkis%C2%AE-dops-und-true) (German only). The 40-cm DOPs of our study area are available for download **[here]**.
{: .notice--info}

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

### Creating vector layers in QGIS

QGIS is an open source GIS.

## Import data in R

```r
THIS IS DUMMY CODE
# 1 - read your data ####
#-----------------------#

rasterStack = raster::stack(file.path(envrmt$sentinel, "sentinel.tif"))
# Polygons:
pol = sf::read_sf(file.path(envrmt$hlnug, "streuobst.gpkg"))

```


## Old material

We use [Sentinel-2](https://sentinel.esa.int/web/sentinel/missions/sentinel-2) satellite data to create spectral indices as predictor variables. You will find a Sentinel-2 scene here. Load the Scene into RStudio and plot an RGB image (Have a look at [this page]( https://sentinels.copernicus.eu/web/sentinel/user-guides/sentinel-2-msi/resolutions/spatial) for information on the wavelength of each band). 
We will also need a bunch of vegetation indices calculated from the sentinel2 data. For this purpose you can have a look at the [indexdatabase]( https://www.indexdatabase.de/) which gives an overview over the existing vegetation indices or the [RStoolbox]( https://cran.r-project.org/web/packages/RStoolbox/index.html), a R package with a great function for this purpose.

Last, we will use data of the Biotopkartierung from Hesse. You can download the data from the [natureg viewer](https://natureg.hessen.de/infomaterial/geodaten.php). Load the data into your RStudio and plot it. Familiarize yourself with its structure. The column containing all the biotope types will be used as response column.
 
