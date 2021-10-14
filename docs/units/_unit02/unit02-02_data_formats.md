---
title: LM | Data Formats
toc: true
header:
  image: /assets/images/unit02/31031723265_0890cd9547_o.jpg
  image_description: "Cloudscape Over the Philippine Sea"
  caption: "Image: [NASA's Marshall Space Flight Center](https://www.nasa.gov/centers/marshall/home/index.html) [CC BY-NC 2.0] via [flickr.com](https://www.flickr.com/photos/nasamarshall/31031723265/)"
---

Features and differences of spatial data collected in the field or acquired by remote sensing systems.
<!--more-->

## Programming environment for dummies
Reality is too complex to be fully represented by data. Models are a basis for reducing complexity. A data model is created through the abstraction of individual objects (entities) and their properties (attributes). In this abstraction process, objects of the same type are bundled (e.g. rivers, roads, urban areas). The spatial data world (including GIS) has implemented two different data models for this purpose -- the raster model and the vector model. Both models can be used to represent continuous properties and discrete (geo-) objects in principle. In practice, however, continuous data is usually represented by the raster model and discrete data by the vector model.

### R packages for spatial data

* [sf](https://r-spatial.github.io/sf/) for working with point & polygon data, also known as [simple features](https://r-spatial.github.io/sf/articles/sf1.html)
* [raster](https://cran.r-project.org/web/packages/raster/index.html) and tutorials for using it for [satellite data analysis](https://rspatial.org/raster/rs/index.html)
* [terra](https://cran.r-project.org/web/packages/terra/index.html) and tutorials for using it for [remote sensing](https://rspatial.org/terra/rs/index.html)
* [envimaR](https://github.com/envima/envimaR) for setting up project and development environments

If `raster` and `terra` are both for working with rasterized (gridded) spatial data, then why are there two packages? And which one should you choose to work with?
{: .notice--info}

The short answer is: both (at the moment). A longer answer is that the newer `terra` package can do more, is easier to use and is faster than the older `raster` package because the former was designed to replace the latter. This is described in greater detail in this [r-bloggers post](https://www.r-bloggers.com/2021/05/a-comparison-of-terra-and-raster-packages/).
{: .notice--info}

## Video
Placeholder, for now:

{% include pdf pdf="GeoAI-02-01_What_is_Remote_Sensing.pdf" %}


## Unit 2 slides

{% include pdf pdf="GeoAI-Unit02.pdf" %}
