--- 
title: Machine Learning versus spatial statistics 
toc: true
header:
  image: /assets/images/unit01/habitat_clipped.jpg
  image_description: "Wetland habitat in Decatur, Georgia, USA"
  caption: "Image: Thomas Cizauskas [CC BY-NC-ND 2.0] via [flickr.com](https://www.flickr.com/photos/cizauskas/51243943456/)" 
---
Now that we have learned the basic concepts of distance neighbourhood and filling spatial gaps, let's take a look at the interpolation or prediction of searched values in space. 

For many decades, deterministic interpolation techniques (inverse distance weighting, nearest neighbour, kriging) have been the most popular spatial interpolation techniques. In particular, external drift kriging and regression kriging are fundamental techniques that use spatial autocorrelation and covariate information, i.e. sophisticated regression statistics.

Machine learning algorithms like random forest have become very popular for spatial environmental prediction. The reason is that they are able to take into account non-linear and complex relationships, thus compensating for certain disadvantages of the usual regression methods.


## Kriging is not the answer (examples) (potential spotlight) This is an example

of simple Euclidean distances vs. complex spped-based distances.
![image](../assets/images/unit01/Hengl_Fig_2_clipped.png) *Image: Distances from
a point derived using different algorithms. Tomislav Hengl, Madlene Nussbaum,
Marvin N. Wright, Gerard B.M. Heuvelink, Benedikt Graeler [CC BY 4.0] via [PeerJ
Life & Environment](https://doi.org/10.7717/peerj.5518/fig-2)*

## Video Placeholder, for now:
{% include pdf pdf="03-02_randomly_good.pdf" %}
## Powerpoint slides as PDF Placeholder, for now:
{% include pdf pdf="03-02_randomly_good.pdf" %}
## Further Readings
https://www.youtube.com/watch?v=KiKjforteXs
https://www.youtube.com/watch?v=reY50t2hbuM
https://www.youtube.com/watch?v=aKq50YM8a8w 

## Exercise
