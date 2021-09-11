--- 
title: Proximity and relationships 
toc: true
header:
  image: /assets/images/unit01/habitat_clipped.jpg
  image_description: "Wetland habitat in Decatur, Georgia, USA"
  caption: "Image: Thomas Cizauskas [CC BY-NC-ND 2.0] via [flickr.com](https://www.flickr.com/photos/cizauskas/51243943456/)"
---

## The first law of geography in heterogeneous spaces.
"Everything is related to everything else, but near things are more related than
distant things" (Tobler, 1970) also known as Tobler's first law (TFL). With this
sentence, Waldo R. Tobler made geographic history, although he was primarily
concerned with reducing the complexity of his population simulation model in
order for it to be calculated on the IT infrastructure of the 1970s. However
world and GI-related questions are much more complicated in space and time and
the usefulness of these approaches in spatial sciences has to be
dicsussed.[Goodchild
2004](https://onlinelibrary.wiley.com/doi/abs/10.1111/j.1467-8306.2004.09402008.x)

This raises some central questions: How can spatial concepts be adequately mapped? When are neighbourly relations regular and continuous, when are they irregular or discrete, and when do they have no meaning at all? 
It is easier to answer these questions with a little background knowledge about the spatial representation of real world features and processes.

## Spatial data representation

First of all, however, it can be considered a fundamental self-image of a scientific discipline that thinks quantitatively to create a transparent, i.e. provable and comprehensible, basis for spatial information. Since, not only for conceptual but also for practical reasons, data are always incomplete (and therefore so is knowledge), improving these incomplete data is an important and often fundamental step towards knowledge and information.

As we have just learned, the roots of spatial analysis reach far back into the past. The willingness to use statistical and other quantitative methods to analyse spatial patterns and processes was particularly pronounced in the spatial sciences, which include the description and explanation of spatial patterns and processes as a central scientific subject (e.g. landscape ecology).

Let us have a glimpse on the repeately mentioned distance relationships 

## Spatial distance

In general spatial relations are described in terms of spatial boundaries and distance. In spatial analysis or prediction, however, it is of central importance to estimate or measure the spatial **influence** between geographical objects. This can be done in a process-oriented functional way, for example the overlying part of a stream flows into the underlying one, or a the data-driven approach, this is usually a function of *neighbourhood* or *distance*.  

The general and serious problem is that spatial influence is very complex and in fact can never be measured. Therefore, there are countless ways to estimate it. 


### Neighbourhood

Neighbourhood is perhaps the most important concept. higher dimensional geo-objects can be considered neighbouring if they *touch* each other, e.g. neighbouring countries. For zero-dimensional objects (points), the most common approach is to use distance in combination with a number of points to determine neighbourhood.


## Distance relations

In analyses of proximity or neighbourhood, it is often a matter of areas of influence or catchment areas, i.e. spatial patterns of effects or processes.

In the following, some methods for calculating distances between spatial objects will be discussed. Because of the different way of discretising space, a distinction must be made -as already familiar- between vector and raster data models.

In the beginning it is often useful to work without spatially restrictive conditions in a first analysis, e.g. when this information is missing. The term "proximity"  refers to a certain imprecision. Qualitative terms that can be used for this are: "near", "far" or "in the neighbourhood of". For representaion and data driven analysis these terms must be objectified and operationalised. This measure must therefore be based on a distance concept, e.g. Euclidean distance or travel times. In a second interpretative step, it must then be decided which units define this type of proximity. In terms of the objective of a question, there are only suitable and less suitable measures, but not right or wrong ones. Therefore, it is of central importance to define a meaningful neighbourhood relationship for the objects under investigation.


### Voronoi polygons - dividing space geometrically

Thiessen or Voronoi polygons are an elementary method for geometrically determining *proximity* or *neighbourhoods*. Voronoi  polygons (see figure below right) can be used when regions are sought that are closest to a point from a set of irregularly distributed points. In the two-dimensional case, a Voronoi  polygon defines an area around a point in which every spatial point is closer to this point than to any other point. Such constructs can also be formed in higher dimensions, giving rise to Voronoi  or Voronoi polyhedra.

{% include gallery id="panel1" caption= "(left) Irregularly distributed points in space (e.g. park benches) , (right) corresponding Voronoi  polygons to the points on the left (GITTA 2005)" layout = "half" %}

Since Voronoi  polygons correspond to an organisational principle frequently observed in nature (e.g. plant cells) and in the spatial sciences (e.g. central places according to Christaller), the possible applications are manifold. The assumption must be made that nothing else is known about the space between the sampled locations and that the boundary line between two samples. The Voronoi  polygons can also be used to delineate catchment areas of shops or service facilities or wells like in the cholera example. Please note that within a polygon, one of the spatial features is isomorphic, i.e. the spatial features are identical. But what if we know more about the spatial relationships of the features?

### Spatial interpolation of data

The *spatial interpolation* of data points provides us with a modelled quasi-continuous estimation of features under the corresponding assumptions. What are spatial interpolations? This means the calculation of unknown values on the basis of neighbouring known values. Most of these techniques are among the more complex methods of spatial analysis, so we will deliberately limit ourselves here to a basic overview of the methods.
*Inverse distance weighting*, *Spline interpolations*, *Kriging methods*,*Polynomial regression methods* are just some very common interpolation methods found in spatial sciences. 

### Continous filling the gaps by interpolation

To get started, take a look at the following figure, which shows you a precipitation surface in Switzerland: The blue dots are the positions of measuring stations, their size corresponds to the amount of precipitation. The different heights of the surface and their colouring are also related to the amount of precipitation.

{% include figure image_path="https://minibsc.gis-ma.org/GISBScL3/de/image/CH_Precip_Example_for_Intro.jpg" alt="Precipitation surface of Switzerland (top), map of measuring stations (bottom). (GITTA 2005)" caption="*Precipitation surface of Switzerland (top), map of measuring stations (bottom). (GITTA 2005)*" %}

### What are the ruling properties of spatial interpolation?

In the example the positions of the meteorological measuring stations are fixed and cannot be freely chosen. However you will have to pay attention to the following properties of the sample (measuring points):

* **Representativeness:** The phenomenon being analysed should be represented in all its manifestations in the sample.
* **Homogeneity:** The spatial interdependence of the data is a very important basic requirement for further meaningful analysis. Two stations at a distance of e.g. 2km from each other should show similar measured values in Ticino as well as in the Jura.
* **Spatial distribution of measurements:** The spatial distribution is of great importance. It can be completely random, regular or clustered. 
* **Size (= number of measurements):** The size of a sample, depends on the phenomenon and the areal area. In some cases, the choice of sample size is subject to practical limitations.

Even more complex. representativeness, homogeneity, spatial distribution and size are interrelated. For example, a size of 5 measuring stations for estimating precipitation for the whole of Switzerland is hardly meaningful and therefore not representative. Equally unrepresentative would be the selection of all measuring stations in German-speaking Switzerland for the estimate of precipitation for the whole of Switzerland. Here, the size alone might be sufficient, but not the spatial distribution. If you now select all stations below 750 m asl, the sample could be correct in terms of both size and spatial distribution, but the phenomenon is not homogeneously represented in the sample. A subsequent estimate would be clearly distorted, especially in areas above 750 mNN.

Imagine that you could measure the precipitation along a measuring path at any position. So you would have a spatially continuous measurement. Neighbouring precipitation values will either be identical or vary slightly, depending on the scale of the "neighbourhood" chosen. In practice, virtually every natural spatially-continuous phenomenon is governed by stochastic fluctuations and can therefore only be described mathematically in approximate terms.




## Video Placeholder, for now:
{% include pdf pdf="03-02_randomly_good.pdf" %}
## Powerpoint slides as PDF Placeholder, for now:
{% include pdf pdf="03-02_randomly_good.pdf" %}

## Further Readings
 

## Quiz