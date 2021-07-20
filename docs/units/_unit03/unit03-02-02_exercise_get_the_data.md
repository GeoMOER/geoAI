---
title: "Exersice: Get your data"
--- 

In this exersice you prepare the data we need to predict the tree species for our area of interest.

1. Sentinel-2
2. lidar
3. Forest inventory data


* Create a rasterstack containing the Sentinel-2 Bands 02, 03, 04, 08, the NDVI and the LiDAR Mean Vegetation Height
* Rename the columns accordingly
* Convert the stack to a data frame
* Print the first five lines of the data frame. What do the rows and columns represent?
* Remove all the rows which contain missing values
* Save your dataframe as an RDS file