---
title: Overview
toc: true
header:
  image: /assets/images/unit04/streuobst.jpg
  image_description: "Streuobstwiese"
  caption: "Image: ulrichstill [CC BY-SA 2.0 DE] via [wikimedia.org](https://commons.wikimedia.org/wiki/File:Tuebingen_Streuobstwiese.jpg)"
---

Deep learning and spatial patterns

<!--more-->

## Recap
The previous exercise gave you an initial impression of the different datasets that we will use for spatial predictions in R. You created your first simple random forest model that predicts the presence of buildings in Marburg. To build the model, you relied on classical methods of machine learning, such as k-fold cross-validation. In the second part, you performed improved upon the first spatial prediction by using advanced techniques, such as forward feature selection and leave-location-out cross-validation.

## This session
We will now delve a little deeper into the field of spatial prediction and use a deep learning technique -- convolutional neural networks -- to detect buildings in Marburg.

## Learning objectives
At the end of this unit you should be able to

* understand the basic concept of a U-Net convolutional neural network
* get your first U-Net up and running and use it to recognize some spatial structures


{% include video id="3WcUTMWa9fU" provider="youtube" %}