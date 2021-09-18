--- 
title: Proximity and relationships 
toc: true
header:
  image: /assets/images/01-splash.jpg
  image_description: "John Snows "
  caption: "Map: [**Dr. John Snow**](https://de.wikipedia.org/wiki/John_Snow_(Mediziner)) [Wellcome Library via wikimedia](https://w.wiki/QtV)"


---

## The first law of geography in heterogeneous spaces.
We come back to the first Tobler's Law (TFL) which in a way made geographic history with the proximity concept, although this simplification was postulated primarily for reasons of the performance weakness of the 1970s computers.  However, as can be deduced from everyday observation, the relationship of things (geoobjects) in space is usually more complex than just a function of distance. Therefore, the usefulness of TFL has been intensively discussed in the spatial sciences [see Goodchild 2004](https://onlinelibrary.wiley.com/doi/abs/10.1111/j.1467-8306.2004.09402008.x).

This raises some central questions: How can spatial concepts be adequately mapped? When are neighborly relations regular and continuous, when are they irregular or discrete, and when do they have no meaning at all?

It is easier to answer these questions with a little background knowledge about the spatial representation of real world features and processes.

When are neighbourhood relations regular, when are they irregular. When are they continuous and when are they discrete and finally there is also space where neighbourhoods have no meaning at all? 

With a little background knowledge about the spatial representation of real world features and processes, these questions can be answered more easily.


## Distance and data representation

The analysis of spatio-temporal processes, as we have seen in the cholera example, reaches far back into the past. The use of quantitative methods, especially statistical methods, is of considerable importance for describing and explaining spatial patterns (e.g. landscape ecology). The central concept on which these methods are based is that of proximity or location to each other.


Let's take a look at the proximity that is mentioned all the time. What exactly is this supposed to be? How can proximity/neighbourliness be expressed in such a way that the space becomes meaningful?

In general, spatial relationships are described in terms of neighbourhoods (positional) and distances (metric). In spatial analysis or prediction, however, it is important to be able to name the spatial **influence**, i.e. the evaluation or weighting of this relationship, qulitatively or quantitatively. Tobler has done this for an objective with his statement near is more important than far.
But what about in other cases? The challenge is that spatial influence can only be measured directly in the exception. Therefore, there are many ways to estimate it. 

### Neighbourhood

Neighborhood is perhaps the most important concept. Higher dimensional geo-objects can be considered neighboring if they *touch* each other, e.g. neighboring countries. For zero-dimensional objects (points), the most common approach is to use distance in combination with a number of points to determine neighborhood.


### Distance

In analyses of proximity or neighborhood, it is often a matter of areas of influence or catchment areas, i.e. spatial patterns of effects or processes.

In the following, some methods for calculating distances between spatial objects will be discussed. Because of the different ways of discretizing space, a distinction must be made - as already familiar - between vector and raster data models.

In the beginning it is often useful to work without spatially restrictive conditions in a first analysis, e.g. when this information is missing. The term "proximity"  refers to a certain imprecision. Qualitative terms that can be used for this are: "near", "far" or "in the neighbourhood of". For representaion and data driven analysis these terms must be objectified and operationalised. This measure must therefore be based on a distance concept, e.g. Euclidean distance or travel times. In a second interpretative step, it must then be decided which units define this type of proximity. In terms of the objective of a question, there are only suitable and less suitable measures, but not right or wrong ones. Therefore, it is of importance to define a meaningful neighbourhood relationship for the objects under investigation.

## Have a try
In the following interactive application you can get an idea of the different concepts of neighbourhood and distance. 
Please note that *rook* is the neighbourhood of 4 and *queen* is the neighbourhood of 8 around a point. For simplicity, the set of darts is a regular grid of 1 km**2 cell size in the district of Marburg Biedenkopf. 
Please also note that the K-nearest neighbours in a regular grid result in a spiral cicular structure.
Irregular polygons or points generate much more complex neighbourhood structures, especially if they are additionally weighted with the help of further spatial influencing variables.

<html>
<head><title>Shiny App Iframe</title></head>
<body>
<iframe id="example1" src="https://gisma.shinyapps.io/proximity/" style="border: none; width: 100%; height: 850px" frameborder="0"></iframe>
</body>
</html>


## Video 
Placeholder, for now:
{% include pdf pdf="03-02_randomly_good.pdf" %}

## Powerpoint slides as PDF 
Placeholder, for now:
{% include pdf pdf="03-02_randomly_good.pdf" %}


## Further Readings
 https://journals.open.tudelft.nl/abe/article/view/5194/4710

**Paper 1**

**Paper 2**

## Assignment
Please choose one of the articles from the further reading section. Your assignment is to summarize the essence of the article in approximately one half page (5-8 sentences).
