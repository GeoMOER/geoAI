---
title: EX | Import and prepare your data

header:
  image: /assets/images/unit03/sentinel_summer.png
  image_description: "Sentinel-2 summer 2019"
  caption: "Image: [© ESA - produced from ESA remote sensing data](https://scihub.copernicus.eu/dhus/#/home)"
 
--- 





In this first exersice we prepare the data that is neccessary to predict tree species groups for a forest in Rhineland-Palatinate with a Random Forest model. A selection of satellite-, lidar-, and polygon data will be used.



We use [Sentinel-2](https://sentinel.esa.int/web/sentinel/missions/sentinel-2) satellite data to create spectral indices as predictor variables. You will find two Sentinel-2 scenes here. One was recorded on the 27.02.2019 (winter.tif) and one on the 27.06.2019 (summer.tif). Load both Scenes into RStudio and plot an RGB image of one of them (Have a look at [this page]( https://sentinels.copernicus.eu/web/sentinel/user-guides/sentinel-2-msi/resolutions/spatial) for information on the wavelength of each band). 
You can mask all non forest areas from the images, as we are only interested in the forest. Calculate a bunch of vegetation indices for both scenes. For this purpose you can have a look at the [indexdatabase]( https://www.indexdatabase.de/) which gives an overview over the existing vegetation indices or the [RStoolbox]( https://cran.r-project.org/web/packages/RStoolbox/index.html), a R package with a great function for this purpose.
	

![image](../assets/images/unit03/lidar.png)
*Image: Lidar data. Jean-Romain Roussel, Tristan R.H. Goodbody, Piotr Tompalski [CC BY-NC-SA 2.0] via [jean-romain.github.io](https://jean-romain.github.io/lidRbook/)*


From the same folder from which you have already downloaded the other data you can also download a raster stack with 18 indices based on lidar data. A detailed description of the indices and their calculation method can be found in the [wiki of the Remote Sensing Database](https://github.com/environmentalinformatics-marburg/rsdb/wiki/Point-cloud-indices). Load this into your RStudio, too.

Last, we will use forest inventory polygon data as training and validation data. Load the data into your RStudio and plot it. Familiarize yourself with its structure. Consider how many tree species groups you are able or wish to predict with the data. Feel free to reduce it by unnecessary columns.

{: .notice--info}
Note: the dataset has been created in german. The most important column is the one with the tree species groups and is named "BAGRu". The tree species are abbreviated with their German names (see table). 

|german | english |
|-------|---------|
|Ei|oak|
|Bu|beech|
|Dou|douglas fir|
|Lä|larch|
|Ki|pine|
|Fi|spruce|
|Ta|fir|
|Lbk|short-lived deciduous trees|
|Lbl| long-lived deciduous trees|
