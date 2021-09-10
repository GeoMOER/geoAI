---
title: Overview
toc: true
header:
  image: /assets/images/unit04/header_ffs.png
  image_description: "Excerpt of predicted tree species groups in Rhineland-Palatinate"
  caption: "Image: © GeoBasis-DE / LVermGeoRP 2018; © OpenStreetMap-contributors; © Hansen/UMD/Google/USGS/NASA; © ESA - produced from ESA remote sensing data"
---

Spatial predictions and robust error estimation
<!--more-->

## Recap

In the previous exercise, you already got a first impression of the different datasets used and dealt with them in R. You also created a first simple random forest model for the prediction of tree species. For this you relied on classical methods of machine learning like n-fold cross-validation. We also discussed the importance of spatial variable selection for spatial prediction.
## This Session

In this unit, we will adapt the random forest model created in the last unit to take more account to the spatiality of the data. For this purpose, we will perform a spatial variable selection and a spatial cross-validation.
We will then delve a little deeper into the field of spatial prediction and use a Deep Learning convolutional neural network to detect spatial structures.

## Learning Objectives

At the end of this unit you should be able to

* understand the concept of a forward-feature-selection (FFS)
* understand the concept of a Leave-Location-Out (LLO) cross-validation
* adapt your modeling workflow to perform FFS and LLO cross-validation
* understand the basic concept of a U-net deep neural network
* to get your first U-net up and running and to recognize some simple spatial structures with it

