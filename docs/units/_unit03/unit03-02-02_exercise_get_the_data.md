---
title: EX | Import and prepare your data
toc: true
header:
  image: /assets/images/unit03/streuobst.jpg
  image_description: "Apples under tree"
  caption: "Image: manfredrichter via [pixabay.com](https://pixabay.com/de/photos/%C3%A4pfel-streuobst-obstbaum-apfelbaum-3684775/)"
  
--- 

In this first exersice we prepare the data that is neccessary to predict orchard meadows in Hesse with a Random Forest model. A selection of satellite-, and polygon data will be used.

We use [Sentinel-2](https://sentinel.esa.int/web/sentinel/missions/sentinel-2) satellite data to create spectral indices as predictor variables. You will find a Sentinel-2 scene here. Load the Scene into RStudio and plot an RGB image (Have a look at [this page]( https://sentinels.copernicus.eu/web/sentinel/user-guides/sentinel-2-msi/resolutions/spatial) for information on the wavelength of each band). 
We will also need a bunch of vegetation indices calculated from the sentinel2 data. For this purpose you can have a look at the [indexdatabase]( https://www.indexdatabase.de/) which gives an overview over the existing vegetation indices or the [RStoolbox]( https://cran.r-project.org/web/packages/RStoolbox/index.html), a R package with a great function for this purpose.

Last, we will use data of the Biotopkartierung from Hesse. You can download the data from the [natureg viewer](https://natureg.hessen.de/infomaterial/geodaten.php). Load the data into your RStudio and plot it. Familiarize yourself with its structure. The column containing all the biotope types will be used as response column.
 
