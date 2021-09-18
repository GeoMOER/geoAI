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

### Neighborhood

Neighborhood is perhaps the most important concept. Higher dimensional geo-objects can be considered neighboring if they *touch* each other, e.g. neighboring countries. For zero-dimensional objects (points), the most common approach is to use distance in combination with a number of points to determine neighborhood.


### Distance

In analyses of proximity or neighborhood, it is often a matter of areas of influence or catchment areas, i.e. spatial patterns of effects or processes.

In the following, some methods for calculating distances between spatial objects will be discussed. Because of the different ways of discretizing space, a distinction must be made - as already familiar - between vector and raster data models.

In the beginning it is often useful to work without spatially restrictive conditions in a first analysis, e.g. when this information is missing. The term "proximity"  refers to a certain imprecision. Qualitative terms that can be used for this are: "near", "far" or "in the neighbourhood of". For representaion and data driven analysis these terms must be objectified and operationalised. This measure must therefore be based on a distance concept, e.g. Euclidean distance or travel times. In a second interpretative step, it must then be decided which units define this type of proximity. In terms of the objective of a question, there are only suitable and less suitable measures, but not right or wrong ones. Therefore, it is of importance to define a meaningful neighbourhood relationship for the objects under investigation.

## Proximity Concepts

### Voronoi polygons - dividing space geometrically

[Voronoi polygons](https://en.wikipedia.org/wiki/Voronoi_diagram){:target="_blank"} (aka Thiessen polygons) are an elementary method for geometrically determining *proximity* or *neighborhoods*. Voronoi polygons (see figure below right) can be used when regions are sought that are closest to a point from a set of irregularly distributed points. In two dimensions, a Voronoi polygon encompasses an area around a point, in which every spatial point is closer to this point than to any other point. Such constructs can also be formed in higher dimensions, giving rise to **Voronoi polygons**.

{% include media url="assets/images/unit01/suisse1.html" %}
[Full-screen version of the map]({{ site.baseurl }}/assets/images/unit01/suisse1.html){:target="_blank"} 
<figure>
  <figcaption>The red dots are rain gauges in Switzerland as an typical example for irregularly distributed points in space. The overlaying colored polygons are the corresponding Voronoi segements determing the corresponding geometrical closest areas (gisma 2021)" </figcaption>
</figure>


Since Voronoi polygons correspond to an organizational principle frequently observed in nature (e.g. plant cells) and in the spatial sciences (e.g. [central places](https://en.wikipedia.org/wiki/Central_place_theory){:target="_blank"}, according to Christaller), the possible applications are manifold. The assumption must be made that nothing else is known about the space between the sampled locations and that the boundary line between two samples.

Voronoi polygons can also be used to delineate catchment areas of shops, service facilities or wells, like in the example of the Soho cholera outbreak. Please note that within a polygon, one of the spatial features is isomorphic, i.e. the spatial features are identical. 

But what if we know more about the spatial relationships of the features? Let's have a look at some crucial concepts.

### Spatial interpolation of data

The *spatial interpolation* of data points provides us with a modeled quasi-continuous estimation of features under the corresponding assumptions. What are spatial interpolations? This means calculating unknown values based on neighboring values that are known. Most of these techniques are among the more complex methods of spatial analysis, so we will deliberately limit ourselves here to a basic overview of the methods. Some of the best known and very common interpolation methods found in spatial sciences are *nearest neighbour* *inverse distance*, *spline interpolations*, *kriging*, and *regression methods* . 

### Continous filling the gaps by interpolation

To get started, take a look at the following figure, which shows you in additon to the overlayed voronoi tesselation six different approches of interpolation methods to derive the spatial precipitation distribution in Switzerland. 

{% include media2 url="assets/images/unit01/suisse6.html" %}
[Full-screen version of the map]({{ site.baseurl }}/assets/images/unit01/suisse6.html){:target="_blank"} 
<figure>
  <figcaption>The blue dots are rain gauges in Switzerland as an typical example for irregularly distributed points in space. The size of the dots is corresponding to the precipitatin ammount in mm. The overlaying colored polygons are the Voronoi segements determing the corresponding geometrical closest areas (gisma 2021)" 
top left: Nearest neighbour interpolation based on 3-5 nearest neighbours, top right: Inverse Distance weighting (IDW) interpolation method
middle left: AutoKriging with no additional parameter, middle right: Thin plate sline regression interpolation method
bottom left: Triangular irregular net (TIN) surface interpolation, bottom right: additive model (GAM) interpolation 
  </figcaption>
</figure>


In the example of precipitation in Switzerland, the positions of the meteorological measuring stations are fixed and cannot be freely chosen. 
But if you decide for an appropriate interpolation method you need to pay attention on the following properties of the samples (distribution and properties of the measuring points):

* **Representativeness of measuring points:** The sample should represent the phenomenon being analyzed in all of its manifestations.
* **Homogeneity of measuring points:** The spatial interdependence of the data is a very important basic requirement for further meaningful analysis. 
* **Spatial distribution of measuring points:** The spatial distribution is of great importance. It can be completely random, regular or clustered. 
* **Number of measuring points):** The number of measurements points depends on the phenomenon and the areal area. In most cases, the choice of sample size is subject to practical limitations.

Even more complex. representativeness, homogeneity, spatial distribution and size are interrelated. For example, a size of 5 measuring stations for estimating precipitation for the whole of Switzerland is hardly meaningful and therefore not representative. Equally unrepresentative would be the selection of all measuring stations in German-speaking Switzerland for the estimate of precipitation for the whole of Switzerland. Here, the number alone might be sufficient, but not the spatial distribution. If you now select all stations below 750 m asl, the sample could be correct in terms of both size and spatial distribution, but the phenomenon is not homogeneously represented in the sample. A subsequent estimate would be clearly distorted, especially in areas above 750 mNN. In practice, virtually every natural spatially-continuous phenomenon is governed by stochastic fluctuations and can therefore only be described mathematically in approximate terms.


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

