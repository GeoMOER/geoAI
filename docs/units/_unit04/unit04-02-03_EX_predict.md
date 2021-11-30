---
title: EX | Predicting using U-Net
toc: true
header:
  image: /assets/images/unit04/streuobst.jpg
  image_description: "Streuobstwiesen"
  caption: "Image: ulrichstill [CC BY-SA 2.0 DE] via [wikimedia.org](https://commons.wikimedia.org/wiki/File:Tuebingen_Streuobstwiese.jpg)"
---

```r

# load a U-Net
unet_model  <-
   load_model_hdf5(file.path(envrmt$path_models, "unet_buildings.hdf5"),
                   compile = TRUE)

# split and prepare the testing data
marburg_mask_test <-
   stack(file.path(envrmt$path_model_testing_data, "marburg_mask_test.tif"))
marburg_dop_test <-
   stack(file.path(envrmt$path_model_testing_data, "marburg_dop_test.tif"))

plan(multisession)

target_rst <-
   subset_ds(
      input_raster = marburg_mask_test,
      path = paste0(file.path(envrmt$path_model_testing_data_bui), "/"),
      mask = TRUE,
      model_input_shape = model_input_shape
   )

subset_ds(
   input_raster = marburg_dop_test,
   path = paste0(file.path(envrmt$path_model_testing_data_dop), "/"),
   mask = FALSE,
   model_input_shape = model_input_shape
)

# write the target_rst to later rebuild your image
writeRaster(
   target_rst,
   file.path(envrmt$path_model_testing_data, "marburg_mask_test_target.tif"),
   overwrite = T
)
```


```r
# one way to see results

# once again list and prepare the files
test_file <- data.frame(
   img = list.files(
      file.path(envrmt$path_model_testing_data_dop),
      full.names = T,
      pattern = "*.png"
   ),
   mask = list.files(
      file.path(envrmt$path_model_testing_data_bui),
      full.names = T,
      pattern = "*.png"
   )
)

testing_dataset <-
   prepare_ds(
      test_file,
      train =FALSE,
      predict = FALSE,
      model_input_shape = model_input_shape,
      batch_size = batch_size
   )

# evaluate the model with test set 
# you can compare these values with the history of your training dataset
ev <- unet_model$evaluate(testing_dataset)
```



```r

# get sample of data from testing data
t_sample <-
   floor(runif(n = 2, min = 1, max = 12))


# simple visual comparison of mask, image and prediction
for (i in t_sample) {
   png_path <- test_file
   png_path <- png_path[i,]
   
   img <- image_read(png_path[, 1])
   mask <- image_read(png_path[, 2])
   pred <-
      image_read(as.raster(predict(object = unet_model, testing_dataset)[i, , ,]))
   
   out <- image_append(c(
      image_annotate(
         mask,
         "Mask",
         size = 10,
         color = "black",
         boxcolor = "white"
      ),
      image_annotate(
         img,
         "Original Image",
         size = 10,
         color = "black",
         boxcolor = "white"
      ),
      image_annotate(
         pred,
         "Prediction",
         size = 10,
         color = "black",
         boxcolor = "white"
      )
   ))
   
   plot(out)
   
}

```


<script src="https://utteranc.es/client.js"
        repo="GeoMOER/geoAI"
        issue-term="GeoAI_2021_unit_04_EX_Predicting_using_Unet"
        theme="github-light"
        crossorigin="anonymous"
        async>
</script>