---
title: "Exersice: Get your data"
--- 

In this exersice you prepare the data that is neccessary to predict tree species groups for a forest in Rhineland-Palatinate with Random Forest.


## 1. Sentinel2 data

Create a raster stack containing all Sentinel2 bands and a selection of Indices.
	* You can use the function spectralInd from the package RStools to 
	
	
## 2. LiDAR

Create a raster stack containing lidar Indices 
During the processing the three dimensional lidar data they get rasterized to different lidar indices

For example:

* Penetration rate understory vegetation
* Canopy Height Model
* BE_H_50 etc.
*...



* Create a rasterstack containing the Sentinel-2 Bands 02, 03, 04, 08, the NDVI and the LiDAR Mean Vegetation Height
* Rename the columns accordingly
* Convert the stack to a data frame
* Print the first five lines of the data frame. What do the rows and columns represent?
* Remove all the rows which contain missing values
* Save your dataframe as an RDS file