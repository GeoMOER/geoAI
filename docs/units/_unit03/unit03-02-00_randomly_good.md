---
title: LM | Randomly Good
toc: true
header:
  image: /assets/images/unit03/streuobst.jpg
  image_description: "Apples under tree"
  caption: "Image: manfredrichter via [pixabay.com](https://pixabay.com/de/photos/%C3%A4pfel-streuobst-obstbaum-apfelbaum-3684775/)"
 
---

Predicting spatial features with machine learning and random validation. 

<!--more-->
## What are we up to?

We will try to predict tree species and their successional stages for a forest in Rhineland-Palatinate with machine learning (random forest), Sentinel-2, LiDAR and forest inventory data.


## Why are we doing this?
Forests are the largest terrestrial Ecosystem in the world and provide a lot of ecosystem services to human wellbeing. Due to drought, parasites (bark beetle), and climate change the forests in Europe are exposed to extreme stress. 
Information about tree species can be very valuable, since all the factors mentioned above can have different impacts depending on the tree species composition. In addition, this can also have an important influence on whether a forest is suitable as a habitat for a species.

![image](../assets/images/unit03/Tuebingen_Streuobstwiese.jpg)
*Image: Streuobstwiese im Frühling. ulrichstill [CC BY-SA 2.0 DE] via [wikipedia.org](https://de.wikipedia.org/wiki/Streuobstwiese#/media/Datei:Tuebingen_Streuobstwiese.jpg)*




## Random forest with random cross-validation - The basics

To accomplish this task, we will use a random forest machine learning approach. As with all other machine learning methods, the random forest model learns to recognize patterns and structures in the data on its own. It is a supervised learning method that requires already labeled data for training.
<p align="center">
  <img src="../assets/images/unit03/machine_learning.jpg">
</p>
*Image: Machine Learning. Chitra Sancheti [CC BY-SA 4.0] via [wikimedia.org](https://commons.wikimedia.org/wiki/File:Artificial_Intelligence_in_E-Commerce.jpg)*

In the following video, we will go into detail about the functionality of the random forest algorithm and the cross-validation validation strategy.

Video here: 

{% include pdf pdf="03-02_randomly_good.pdf" %}



