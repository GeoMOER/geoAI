--- 
title: Machine Learning versus spatial statistics 
toc: true
header:
  image: /assets/images/01-splash.jpg
  image_description: "John Snows "
  caption: "Map: [**Dr. John Snow**](https://de.wikipedia.org/wiki/John_Snow_(Mediziner)) [Wellcome Library via wikimedia](https://w.wiki/QtV)"
---
Now that we have learned the basic concepts of distance neighbourhood and filling spatial gaps, let's take a look at the interpolation or prediction of searched values in space. 

For many decades, deterministic interpolation techniques (inverse distance weighting, nearest neighbour, kriging) have been the most popular spatial interpolation techniques. In particular, external drift kriging and regression kriging are fundamental techniques that use spatial autocorrelation and covariate information, i.e. sophisticated regression statistics.

Machine learning algorithms like random forest have become very popular for spatial environmental prediction. The reason is that they are able to take into account non-linear and complex relationships, thus compensating for certain disadvantages of the usual regression methods.



## Filling the gaps 
## Geostatical modeling 
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


### Machine learning  

Machine learning methods such as Random Forest can also produce spatial and temporal predictions (i.e. produce maps from point observations). 
In particular, taking spatial autocorrelation into account can improve predictions or interpolations by adding geographic distances and can map much more complex relationships and dependencies.
In the simplest case, the results are comparable to the well-known model-based geostatistics. The advantage of ML methods over model-based geostatistics, however, is that they make fewer assumptions, can take non-linearities into account and are easier to automate.

{% include media url="assets/images/unit01/ML_interpol.png"%}

<figure>
  <figcaption> The original dataset (top left) is a terrain model reduced to 8 metres with 48384 single pixels. 
For interpolation, 1448 points were randomly drawn and interpolated with conventional kriging (top right), support vector machines (SVM) (middle left), neural networks (middle right), and two variants of random forest (bottom row). In all methods, only the distance of the drawn points is used as a dependency.s   
  </figcaption>
</figure>

All interpolations have been applied "by default". Possible tuning can lead to significant changes in all of them.
The error measures are correlated to the visual results:   Kriging and the neural network show the best performance. Followed by the Random Forest models and the Support Vector Machine.

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> model </th>
   <th style="text-align:left;"> total_error </th>
   <th style="text-align:left;"> mean_error </th>
   <th style="text-align:left;"> sd_error </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Kriging </td>
   <td style="text-align:left;"> 15797773.0 </td>
   <td style="text-align:left;"> 54.2 </td>
   <td style="text-align:left;"> 67.9 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Neural Network </td>
   <td style="text-align:left;"> 19772241.0 </td>
   <td style="text-align:left;"> 67.8 </td>
   <td style="text-align:left;"> 80.5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Random Forest </td>
   <td style="text-align:left;"> 20540628.1 </td>
   <td style="text-align:left;"> 70.4 </td>
   <td style="text-align:left;"> 82.5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Normalized Random Forest </td>
   <td style="text-align:left;"> 20597969.8 </td>
   <td style="text-align:left;"> 70.6 </td>
   <td style="text-align:left;"> 82.7 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Support Vector Machine </td>
   <td style="text-align:left;"> 21152987.7 </td>
   <td style="text-align:left;"> 72.5 </td>
   <td style="text-align:left;"> 68.3 </td>
  </tr>
</tbody>
</table>

## Video
Placeholder, for now:
{% include pdf pdf="03-02_randomly_good.pdf" %}

## Powerpoint slides as PDF
Placeholder, for now:
{% include pdf pdf="03-02_randomly_good.pdf" %}


## Additional references
Get the Most Out of AI, Machine Learning, and Deep Learning [Part 1](https://www.youtube.com/watch?v=KiKjforteXs){:target="_blank"} (10:52) and [Part 2](https://www.youtube.com/watch?v=Ys33AhNDwC4){:target="_blank"} (13:18)

[Why You Should NOT Learn Machine Learning!](https://youtu.be/reY50t2hbuM){:target="_blank"} (6:17)

[GeoAI: Machine Learning meets ArcGIS](https://youtu.be/aKq50YM8a8w){:target="_blank"} (8:50)

## Further Readings
https://www.youtube.com/watch?v=KiKjforteXs
https://www.youtube.com/watch?v=reY50t2hbuM
https://www.youtube.com/watch?v=aKq50YM8a8w 

## Assignment
Set up Docker environment (more to follow soon)

