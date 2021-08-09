---
title: "LM | From data reproduction to spatial prediction - Why latitude and longitude are (almost) never good predictor variables"
toc: true
header:
  image: /assets/images/unit03/header_variables.png
  image_description: "Cutout from  Measured carbon dioxide concentrations in Vancouver"
  caption: "Bild: [flickr](https://flic.kr/p/RNxn74) / CC-BY-2.0"
---


The appropriate collection of training data is essential for all monitored classifications. In theory, the rules to be followed are simple, but it is often difficult to achieve a robust, practical application. 
<!--more-->

![image](../assets/images/unit03/variables.png)
*Example of spatial predictor variables*


Please note that especially the spatial validation concepts is a cutting edge theme for spatial prediction of data. The following talks will give you a brief introduction
{: .notice--info} 

## Talks

[Machine learning applications in environmental remote sensing](https://www.youtube.com/watch?v=mkHlmYEzsVQ&list=PLXUoTpMa_9s1npXD6S9M0_2pUgnTd6cqV&index=11&t=0s){:target="_blank"}

[Machine learning in remote sensing applications Moving from data reproduction to spatial prediction" (practical)](https://htmlpreview.github.io/?https://github.com/HannaMeyer/OpenGeoHub_2019/blob/master/practice/ML_LULC.html){:target="_blank"}

## Reference
[Importance of spatial predictor variable selection in machine learning applications - Moving from data reproduction to spatial prediction](https://www.researchgate.net/publication/335819474_Importance_of_spatial_predictor_variable_selection_in_machine_learning_applications_-Moving_from_data_reproduction_to_spatial_prediction){:target="_blank"}

 
# For your prediction

* try not to use variables that have an ID characteristic to them (are always the same for each pixel). They will most likely be unsuitable for spatial predictions,
* if your variables are highly correlated (use this tutorial to check it) try to eliminate the ones that are very similar.





https://ilias.uni-marburg.de/data/UNIMR/lm_data/lm_2285471/unit05/unit04-07_spatial_trainingdata.html