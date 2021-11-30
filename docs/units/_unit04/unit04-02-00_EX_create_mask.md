---
title: EX | Create Masks
toc: true
header:
  image: /assets/images/unit04/streuobst.jpg
  image_description: "Excerpt of predicted tree species groups in Rhineland-Palatinate"
  caption: "Image: ulrichstill [CC BY-SA 2.0 DE] via [wikimedia.org](https://commons.wikimedia.org/wiki/File:Tuebingen_Streuobstwiese.jpg)"
---

In this exercise, we will create a raster mask from vector data containing the outlines of all buildings in our study area in the southern part of Marburg (image below). For this purpose, both the raster mask and the DOP of the study area will be split from large raster (.tif) files into many smaller image files (.png).

{% include media4 url="assets/images/unit04/marburg_buildings.html" %} [Full screen version of the map]({{ site.baseurl }}assets/images/unit04/marburg_buildings.html){:target="_blank"}


## Set up a working environment

First, set up the working environment as described in [Unit 01](https://geomoer.github.io/geoAI//unit01/unit01-04_setup_working_environment.html).
We will add some more packages and an additional folder to your setup script. In the "modelling" folder you can store your prepared data, your models, your predictions etc.

```r
require(envimaR)

packagesToLoad = c(
   "raster",
   "rgdal",
   "png",
   "gdalUtils",
   "future.apply",
   "tensorflow",
   "keras",
   "reticulate",
   "sf",
   "osmdata",
   "greenbrown",
   "rsample",
   "tfdatasets",
   "purrr",
   "stars",
   "magick"
)

# define a project rootfolder
rootDir = "~/edu/geoAI"  

# some new paths
projectDirList   = c(
   "data/",
   "data/modelling/",
   "data/modelling/model_training_data/",
   "data/modelling/model_training_data/dop/",
   "data/modelling/model_training_data/bui/",
   "data/modelling/models/",
   "data/modelling/prediction/",
   "data/modelling/validation/",
   "data/modelling/model_testing_data/",
   "data/modelling/model_testing_data/dop/",
   "data/modelling/model_testing_data/bui/",
   "docs/",
   "run/",
   "tmp",
   "src/",
   "src/functions/"
)

# Now set automatically root direcory, folder structure and load libraries
envrmt = envimaR::createEnvi(
   root_folder = rootDir,
   folders = projectDirList,
   path_prefix = "path_",
   libs = packagesToLoad,
   alt_env_id = "COMPUTERNAME",
   alt_env_value = "PCRZP",
   alt_env_root_folder = "F:/BEN/edu"
)
## set raster temp path
raster::rasterOptions(tmpdir = envrmt$path_tmp)
```

## Create raster mask from vector file

From the file shown in the figure above, containing the outlines of the buildings in the study area, we will first create a raster mask. To do this, we use the DOP of the study area as a reference raster, to ensure that the mask will have the same extent and the same resolution. The transformation of polygons into a raster file with the same properties as the DOP is done by the function rasterize of the raster package. Afterwards a reclassification of the values is performed, where all values that do not represent a building are 0 and all values that represent a building are 1. You can roughly see how the mask for the study area might look in the map below (layer mask).


```r

# read data
ras <- raster::stack(file.path(envrmt$path_data, "marburg_dop.tif"))

# subset to three channels
ras <- subset(ras, c("red", "green", "blue"))

# download and crop the OSM building data to the extent of the raster data
buildings = opq(bbox = "marburg de") %>%
   add_osm_feature(key = "building") %>%
   osmdata_sf()

buildings = buildings$osm_polygons

buildings = sf::st_transform(buildings, crs(ras))

ras_extent <- extent(ras)

buildings <- sf::st_crop(buildings[1], ras_extent)

```



## Function to split the data


To train the unet, many smaller images of the same size are needed instead of the large raster files we have at the moment. We will use the function below to split the raster files. Although it may seem a bit complex at first glance, it basically consists of five simple steps: 

1. determine the size of the original raster (DOP)
2. determine how many images of a certain size (e.g. 128 by 128) can fit into it and how large the extent of all the images is in total.
3. crop the original grid to the new size (a multiple of 128x128).
4. create a grid with polygons over the cropped raster (see layer images in the image below)
5. crop every polygon to both the house mask and the DOP and save the small 128x128 images as .png

```r

subset_ds <-
  function(input_raster,
           model_input_shape,
           path,
           targetname = "",
           mask = FALSE) {
    # determine next number of quadrats in x and y direction, by simple rounding
    targetsizeX <- model_input_shape[1]
    targetsizeY <- model_input_shape[2]
    inputX <- ncol(input_raster)
    inputY <- nrow(input_raster)
    
    # determine dimensions of raster so that
    # it can be split by whole number of subsets (by shrinking it)
    while (inputX %% targetsizeX != 0) {
      inputX = inputX - 1
    }
    while (inputY %% targetsizeY != 0) {
      inputY = inputY - 1
    }
    
    # determine difference
    diffX <- ncol(input_raster) - inputX
    diffY <- nrow(input_raster) - inputY
    
    # determine new dimensions of raster and crop,
    # cutting evenly on all sides if possible
    newXmin <- floor(diffX / 2)
    newXmax <- ncol(input_raster) - ceiling(diffX / 2) - 1
    newYmin <- floor(diffY / 2)
    newYmax <- nrow(input_raster) - ceiling(diffY / 2) - 1
    rst_cropped <-
      suppressMessages(crop(
        input_raster,
        extent(input_raster, newYmin, newYmax, newXmin, newXmax)
      ))
    
    agg <-
      suppressMessages(aggregate(rst_cropped[[1]], c(targetsizeX, targetsizeY)))
    agg[]    <- suppressMessages(1:ncell(agg))
    agg_poly <- suppressMessages(rasterToPolygons(agg))
    names(agg_poly) <- "polis"
    
    if (mask) {
      future_lapply(
        seq_along(agg),
        FUN = function(i) {
          subs <- local({
            e1  <- extent(agg_poly[agg_poly$polis == i, ])
            
            subs <- suppressMessages(crop(rst_cropped, e1))
            
          })
          writePNG(
            as.array(subs),
            target = paste0(path, targetname, i, ".png")
          )
        }
      )
    }
    else{
      future_lapply(
        seq_along(agg),
        FUN = function(i) {
          subs <- local({
            e1  <- extent(agg_poly[agg_poly$polis == i, ])
            
            subs <- suppressMessages(crop(rst_cropped, e1))
            # rescale to 0-1, for png export
            if (mask == FALSE) {
              subs <-
                suppressMessages((subs - cellStats(subs, "min")) / (cellStats(subs, "max") -
                                                                      cellStats(subs, "min")))
            }
          })
          writePNG(
            as.array(subs),
            target = paste0(path, targetname, i, ".png")
          )
        }
      )
    }
    rm(subs, agg, agg_poly)
    gc()
    return(rst_cropped)
  }


```


{% include media4 url="assets/images/unit04/marburg_buildings_masked.html" %} [Full screen version of the map]({{ site.baseurl }}assets/images/unit04/marburg_buildings_masked.html){:target="_blank"}



## Function to remove files without training data

In this example we will only use the images to train the unet that also contains one of the objects we want to detect (a building). Therefore we will use the following function to remove from all .pngs, that have only one value in the mask (0 no house), both the mask image and the corresponding DOP .png.

```r

remove_files <- function(df) {
  future_lapply(
    seq(1, nrow(df)),
    FUN = function(i) {
      local({
        fil = df$list_m[i]
        png = readPNG(fil)
        len = length(png)
        if (AllEqual(png)) {
          file.remove(df$list_s[i])
          file.remove(df$list_m[i])
        } else {
        }
      })
    }
  )
}
```




## Split Mask and DOP and remove empty files

Now we can apply our functions defined above to our data. Both the DOP and the mask are split into smaller .pngs using the subset_ds function. The output path for both functions is in a different folder, where the images should be stored.  

```r
# rasterize the buildings
rasterized_vector <- rasterize(buildings, ras[[1]])

# reclassify to 0 and 1
rasterized_vector[is.na(rasterized_vector[])] <- 0
rasterized_vector[rasterized_vector > 1] <- 1

#save
raster::writeRaster(rasterized_vector,
                    file.path(envrmt$path_data, "marburg_mask.tif"),
                    overwrite = T)
```
## 2. Divide dataset to training and testing 
```r
# divide to training and testing extent
e_test <- extent(483000, 484000, 5626000, 5628000)
e_train <- extent(480000, 483000, 5626000, 5628000)

marburg_mask_train <- crop(rasterized_vector, e_train)
marburg_dop_train <- crop(ras, e_train)

marburg_mask_test <-  crop(rasterized_vector, e_test)
marburg_dop_test <- crop(ras, e_test)

writeRaster(
   marburg_mask_test,
   file.path(envrmt$path_model_testing_data, "marburg_mask_test.tif"),
   overwrite = T
)
writeRaster(
   marburg_dop_test,
   file.path(envrmt$path_model_testing_data, "marburg_dop_test.tif"),
   overwrite = T
)
writeRaster(
   marburg_mask_train,
   file.path(envrmt$path_model_training_data, "marburg_mask_train.tif"),
   overwrite = T
)
writeRaster(
   marburg_dop_train,
   file.path(envrmt$path_model_training_data, "marburg_dop_train.tif"),
   overwrite = T
)
```



```r
# 3. Subset the datasets  -------------------------------------------------

# subset data set function
# this function uses future.apply package so it multicore process

subset_ds <-
   function(input_raster,
            model_input_shape,
            path,
            targetname = "",
            mask = FALSE) {
      # determine next number of quadrats in x and y direction, by simple rounding
      targetsizeX <- model_input_shape[1]
      targetsizeY <- model_input_shape[2]
      inputX <- ncol(input_raster)
      inputY <- nrow(input_raster)
      
      # determine dimensions of raster so that
      # it can be split by whole number of subsets (by shrinking it)
      while (inputX %% targetsizeX != 0) {
         inputX = inputX - 1
      }
      while (inputY %% targetsizeY != 0) {
         inputY = inputY - 1
      }
      
      # determine difference
      diffX <- ncol(input_raster) - inputX
      diffY <- nrow(input_raster) - inputY
      
      # determine new dimensions of raster and crop,
      # cutting evenly on all sides if possible
      newXmin <- floor(diffX / 2)
      newXmax <- ncol(input_raster) - ceiling(diffX / 2) - 1
      newYmin <- floor(diffY / 2)
      newYmax <- nrow(input_raster) - ceiling(diffY / 2) - 1
      rst_cropped <-
         suppressMessages(crop(
            input_raster,
            extent(input_raster, newYmin, newYmax, newXmin, newXmax)
         ))
      
      agg <-
         suppressMessages(aggregate(rst_cropped[[1]], c(targetsizeX, targetsizeY)))
      agg[]    <- suppressMessages(1:ncell(agg))
      agg_poly <- suppressMessages(rasterToPolygons(agg))
      names(agg_poly) <- "polis"
      
      if (mask) {
         future_lapply(
            ### error ### 
            # one time a warning
            # one time this does not work!
            # genauer gesagt taucht der fehler nur beim dop auf Lösung lapply
            # also could not remove subs --> sollte an local liegen 
            seq_along(agg),
            FUN = function(i) {
               subs <- local({
                  e1  <- extent(agg_poly[agg_poly$polis == i,])
                  
                  subs <- suppressMessages(crop(rst_cropped, e1))
                  
               })
               writePNG(as.array(subs),
                        target = paste0(path, targetname, i, ".png"))
            }
         )
      }
      else{
         future_lapply(
            seq_along(agg),
            FUN = function(i) {
               subs <- local({
                  e1  <- extent(agg_poly[agg_poly$polis == i,])
                  
                  subs <- suppressMessages(crop(rst_cropped, e1))
                  # rescale to 0-1, for png export
                  if (mask == FALSE) {
                     subs <-
                        suppressMessages((subs - cellStats(subs, "min")) / (cellStats(subs, "max") -
                                                                               cellStats(subs, "min")))
                  }
               })
               writePNG(as.array(subs),
                        target = paste0(path, targetname, i, ".png"))
            }
         )
      }
      rm(subs, agg, agg_poly)
      gc()
      return(rst_cropped)
   }

# read training data
marburg_mask_train <-
   stack(file.path(envrmt$path_model_training_data, "marburg_mask_train.tif"))
marburg_dop_train <-
   stack(file.path(envrmt$path_model_training_data, "marburg_dop_train.tif"))

# set the size of each image
model_input_shape = c(128, 128)

# start your paralell computing
# with plan(multisession, workers = 2) 
# you can set the number of background process
plan(multisession)

# subsets for the mask

subset_ds(
   input_raster = marburg_mask_train,
   path = paste0(file.path(envrmt$path_model_training_data_bui), "/"),
   mask = TRUE,
   model_input_shape = model_input_shape
)

# subsets for the dop
subset_ds(
   input_raster = marburg_dop_train,
   path = paste0(file.path(envrmt$path_model_training_data_dop), "/"),
   mask = FALSE,
   model_input_shape = model_input_shape
)
```

```r
# remove all masks with just background information and
# keep the foreground (building) information

remove_files <- function(df) {
   future_lapply(
      seq(1, nrow(df)),
      FUN = function(i) {
         local({
            fil = df$list_masks[i]
            png = readPNG(fil)
            len = length(png)
            if (AllEqual(png)) {
               file.remove(df$list_dops[i])
               file.remove(df$list_masks[i])
            } else {
               
            }
         })
      }
   )
}

# list all created files in both folders
list_dops <-
   list.files(paste0(file.path(envrmt$path_model_training_data_dop), "/"),
              full.names = TRUE,
              pattern = "*.png")
list_masks <-
   list.files(paste0(file.path(envrmt$path_model_training_data_bui), "/"),
              full.names = TRUE,
              pattern = "*.png")

# create a data frame
df = data.frame(list_dops, list_masks)

remove_files(df)
```




## Expected Output
At the end of this exercise you should have created a raster mask from the v

![image](../assets/images/unit04/masks.png)
*Image: *

<script src="https://utteranc.es/client.js"
        repo="GeoMOER/geoAI"
        issue-term="GeoAI_2021_unit_04_EX_Create Masks"
        theme="github-light"
        crossorigin="anonymous"
        async>
</script>