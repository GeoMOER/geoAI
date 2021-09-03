---
title: LM | Data Formats
toc: true
header:
  image: /assets/images/02-splash.jpg
  image_description: "Blick ins Lahntal mit Grünlandwirtschaft, Baustelle für Stromtrassen und Regenbogen."
  caption: "Foto: T. Nauss / CC0"
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

The short answer is: both (at the moment). A longer answer is that the newer `terra` package can do more, is easier to use and is faster than the older `raster` package because the former was designed to replace the latter. This is described in greater detail in this [r-bloggers post](https://www.r-bloggers.com/2021/05/a-comparison-of-terra-and-raster-packages/).

## Quiz about RS and spatial data
