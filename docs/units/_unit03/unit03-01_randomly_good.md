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

Our goal is to determine areas of **Streuobstwiese** in the German state Hesse. To accomplish this goal, we will use a machine learning approach together with DOPs (digital orthophoto) as well as field surveys of the Hessian State Agency for Nature Conservation, Environment and Geology ([Hessisches Landesamt fuer Naturschutz, Umwelt und Geologie; HLNUG](https://www.hlnug.de/)).

## Why orchard meadows?
[**Streuobstwiese**](https://en.wikipedia.org/wiki/Orchard#Central_Europe) (engl. orchard meadows), i.e. tall, large-crowned fruit trees scattered mostly on grassland, are among the most endangered and species-rich biotopes in Central Europe. Until the beginning of the 20th century, they were the predominant commercial form of fruit production and were primarily farmed for economic reasons. **Streuobstwiese** became economically uninteresting after low-trunk fruit trees were introduced and the general economic situation changed after World War II. Many simply fell into ruin due to lack of care, lack of new plantings or abandonment. This trend was reversed in the 1980s, as aspects of landscape aesthetics and nature conservation became more important.

The diverse structure of the **Streuobstwiese** provides a multitude of ecological gradients. They create diverse ecological niches for both plants and animals in a relatively small space and over time, making it one of the most species-rich biotopes in Europe. This semi-natural habitat is strongly dependent on regular maintenance, however, as new plantings, tree pruning and mowing are necessary for the great species diversity to continue to exist.

![image](../assets/images/unit03/Tuebingen_Streuobstwiese.jpg)
*Image: Streuobstwiese in Western Europe. ulrichstill [CC BY-SA 2.0 DE] via [wikipedia.org](https://de.wikipedia.org/wiki/Streuobstwiese#/media/Datei:Tuebingen_Streuobstwiese.jpg)*

Information on the spatial distribution and the acreage of **Streuobstwiese** is necessary to observe their development and devise specific policy recommendations for the authorities. In addition to monitoring, the German state of Hesse (as well as in five other states) requires them to be registered, since **Streuobstwiese** outside of developed areas are protected by state and federal law (Federal Nature Conservation Act).

Until now, these legally protected areas were recorded in the Hessian Habitat and Biotope Mapping (Hessische Lebensraum- und Biotopkartierung; HLBK) or its predecessor. However, manual records make it difficult to obtain regular and extensive information on their condition. **Streuobstwiese** have already been surveyed for the current HLBK, which HLNUG has made available to this course and we will use as training data. The more detailed criteria of the surveyed orchard areas can be found in the mapping unit description (Kartiereinheitenbeschreibung).


## Random forest -- The basics
To accomplish this task, we will use a random forest machine learning approach. As with all other machine learning methods, the random forest model learns to recognize patterns and structures in the data on its own. Before it can learn, however, it must be given training data, which makes it a supervised learning method. The training data must be labeled with different classification categories for the algorithm to classify areas of **Streuobstwiese** correctly.

<p align="center">
  <img src="../assets/images/unit03/machine_learning.jpg">
</p>
*Image: Machine Learning. Chitra Sancheti [CC BY-SA 4.0] via [wikimedia.org](https://commons.wikimedia.org/wiki/File:Artificial_Intelligence_in_E-Commerce.jpg)*



{% include video id="Yh9KGcxT_O4" provider="youtube" %}

## Unit 3 slides

{% include pdf pdf="GeoAI-Unit03.pdf" %}


## Additional resources
### Machine learning
Here are several videos that introduce the broad field of machine learning, in general, as well as the specific algorithm that we will use in this course: random forest. In addition to these videos, we encourage you to conduct independent research, as there are some great tutorials on the Internet.

1. [A Gentle Introduction to Machine Learning (12:44)](https://www.youtube.com/watch?v=Gv9_4yMHFhI&list=PLblh5JKOoLUICTaGLRoHQDuF_7q2GfuJF){:target="_blank"}  
2. [Decision Trees (17:21)](https://www.youtube.com/watch?v=7VeUPuFGJHk){:target="_blank"}  
3. [Decision Trees Part 2 - Feature Selection and Missing Data (5:15)](https://www.youtube.com/watch?v=wpNl-JwwplA){:target="_blank"}  
4. [Random Forests Part 1 - Building, Using and Evaluating (9:53)](https://www.youtube.com/watch?v=J4Wdy0Wc_xQ){:target="_blank"}  
5. [Random Forests Part 2 - Missing data and clustering (11:52)](https://www.youtube.com/watch?v=sQ870aTKqiM){:target="_blank"}  
6. [Random Forests in R (15:09)](https://www.youtube.com/watch?v=6EXPYzbfLCE){:target="_blank"}  
7. [Machine Learning Fundamentals - Cross Validation (6:04)](https://www.youtube.com/watch?v=fSytzGwwBVw){:target="_blank"}

### Literature about **Streuobstwiese**
Fink, Peter; Heinze, Stefanie; Raths, Ulrike; Riecken, Uwe; Ssymank, Axel. [Naturschutz und Biologische Vielfalt Heft 156: Rote Liste der gefaehrdeten Biotoptypen Deutschlands](https://bfn.buchweltshop.de/nabiv-heft-156-rote-liste-der-gefahrdeten-biotoptypen-deutschlands.html). Bundesamt fuer Naturschutz (2017). [German]

Herzog, Felix. Streuobst: a traditional agroforestry system as a model for agroforestry development in temperate Europe. Agroforestry Systems 42, 61-80 (1998). [https://doi.org/10.1023/A:1006152127824](https://doi.org/10.1023/A:1006152127824)

Herzog, Felix; Oetmann, Anja. [Communities of Interest and Agro-Ecosystem Restoration: Streuobst in Europe in Interactions Between Agroecosystems and Rural Communities](https://www.taylorfrancis.com/chapters/edit/10.1201/9781420041385-11/communities-interest-agro-ecosystem-restoration-streuobst-europe-felix-herzog-anja-oetmann), edited by Flora, Cornelia. Boca Raton: CRC Press (2001). 

Hessian Habitat and Biotope Mapping ([Hessische Lebensraum- und Biotopkartierung; HLBK](https://www.hlnug.de/themen/naturschutz/lebensraeume-und-biotopkartierungen/biotopkartierungen/hessische-lebensraum-und-biotopkartierung-hlbk-ab-2014)) [German]

Silbereisen, Robert; Herzberger, Erwin. [Obstbaeume in der Landschaft](https://www.amazon.de/Obstb%C3%A4ume-Landschaft-Rupprecht-Lucke/dp/3800155389), edited by Lucke, Rupprecht. Stuttgart: Ulmer (1992). [German]

Zehnder, Markus; Weller, Friedrich. [Streuobstbau: Obstwiesen erleben und erhalten.](https://www.amazon.de/Streuobstbau-Obstwiesen-erhalten-Markus-Zehnder/dp/3800108100) 3rd Edition. Stuttgart: Ulmer (2016). [German]
