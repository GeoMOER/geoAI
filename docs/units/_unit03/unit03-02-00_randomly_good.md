---
title: LM | Randomly Good
toc: true
header:
  image: /assets/images/unit03/streuobst.jpg
  image_description: "Apples under tree"
  caption: "Image: manfredrichter via [pixabay.com](https://pixabay.com/de/photos/%C3%A4pfel-streuobst-obstbaum-apfelbaum-3684775/)"
 
---

Predicting spatial features with machine learning and random validation. 

We would like to determine areas in Hesse that contain orchard meadows. For this we will use a machine learning approach, together with DOPs (digital orthophoto) as well as orchard meadows field surveys of the Hessian State Agency for Nature Conservation, Environment and Geology.

<!--more-->




## Why are we doing this?
Forests are the largest terrestrial Ecosystem in the world and provide a lot of ecosystem services to human wellbeing. Due to drought, parasites (bark beetle), and climate change the forests in Europe are exposed to extreme stress. 
Information about tree species can be very valuable, since all the factors mentioned above can have different impacts depending on the tree species composition. In addition, this can also have an important influence on whether a forest is suitable as a habitat for a species.

![image](../assets/images/unit03/Tuebingen_Streuobstwiese.jpg)
*Image: Streuobstwiese in Western Europe. ulrichstill [CC BY-SA 2.0 DE] via [wikipedia.org](https://de.wikipedia.org/wiki/Streuobstwiese#/media/Datei:Tuebingen_Streuobstwiese.jpg)*


## Random forest with random cross-validation -- The basics
To accomplish this task, we will use a random forest machine learning approach. As with all other machine learning methods, the random forest model learns to recognize patterns and structures in the data on its own. Before it can learn, however, it must be given training data, which makes it a supervised learning method. The training data must be labeled with different classification categories for the algorithm to classify areas of **Streuobstwiese** correctly.

<p align="center">
  <img src="../assets/images/unit03/machine_learning.jpg">
</p>
*Image: Machine Learning. Chitra Sancheti [CC BY-SA 4.0] via [wikimedia.org](https://commons.wikimedia.org/wiki/File:Artificial_Intelligence_in_E-Commerce.jpg)*



{% include video id="Yh9KGcxT_O4" provider="youtube" %}

## Unit 3 slides

{% include pdf pdf="GeoAI-Unit03.pdf" %}


## Additional resources
Here are several videos that introduce the broad field of machine learning, in general, as well as the specific algorithm that we will use in this course: random forest. In addition to these videos, we encourage you to conduct independent research, as there are some great tutorials on the Internet.

1. [A Gentle Introduction to Machine Learning (12:44)](https://www.youtube.com/watch?v=Gv9_4yMHFhI&list=PLblh5JKOoLUICTaGLRoHQDuF_7q2GfuJF){:target="_blank"}  
2. [Decision Trees (17:21)](https://www.youtube.com/watch?v=7VeUPuFGJHk){:target="_blank"}  
3. [Decision Trees Part 2 - Feature Selection and Missing Data (5:15)](https://www.youtube.com/watch?v=wpNl-JwwplA){:target="_blank"}  
4. [Random Forests Part 1 - Building, Using and Evaluating (9:53)](https://www.youtube.com/watch?v=J4Wdy0Wc_xQ){:target="_blank"}  
5. [Random Forests Part 2 - Missing data and clustering (11:52)](https://www.youtube.com/watch?v=sQ870aTKqiM){:target="_blank"}  
6. [Random Forests in R (15:09)](https://www.youtube.com/watch?v=6EXPYzbfLCE){:target="_blank"}  
7. [Machine Learning Fundamentals - Cross Validation (6:04)](https://www.youtube.com/watch?v=fSytzGwwBVw){:target="_blank"}  




