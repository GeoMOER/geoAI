---
title: LM | Remote Sensing
toc: true
header:
  image: /assets/images/unit02/31031723265_0890cd9547_o.jpg
  image_description: "Cloudscape Over the Philippine Sea"
  caption: "Image: NASA's Marshall Space Flight Center [CC BY-NC 2.0] via [flickr.com](https://www.flickr.com/photos/nasamarshall/31031723265/)"
---

A brief introduction to remote sensing using optical sensors as an example.
<!--more-->

## What is remote sensing?
Text text text

Still need to include:
* Scan angle dependence
* Reflection, transmission, absorption
* Scanner technique using Sentinel as an example, pixel size nadir vs. edges


## Physical fundamentals

### Laws

#### Planck's law (Plancksches Strahlungsgesetz)
Every physical body spontaneously and continuously emits electromagnetic radiation. The spectral radiance of a given body describes the spectral emissive power for particular radiation frequencies, based on area and angle. The formula for Planck's law is given as:
<p align="center">
  <img src="../assets/images/unit02/Planck_formula_wavelength.png">
</p>

This shows how radiated energy emitted at shorter wavelengths (&lambda;) increases more rapidly with temperature (&Tau;) than energy emitted at longer wavelengths (&lambda;). This formula can also be rewritten in terms of frequency (&upsilon;) and other variables. Planck's radiation law shows how the radiation intensity is distributed across a single wavelength. It reveals that as temperature increases, so too does the total radiated energy of a body.

<p align="center">
  <img src="../assets/images/unit02/Plancks_law.png">
</p>
*Image: Visualization of Plank's law and Wien's displacement law. 4C [CC BY-SA 3.0] via [wikimedia.org](https://en.wikipedia.org/wiki/File:Wiens_law.svg)*

#### Wien's displacement law (Wiensche Verschiebungsgesetz)
Another fundamental law of black-body radiation, Wien's displacement law describes where the maximum intensity of a wavelength lies. This maximum intensity is inveresly proportional to the temperature of the emitting body. This inverse relationship between wavelength and temperature means that as temperature increase, the wavelength of the thermal radiation becomes smaller.

<p align="center">
  <img src="../assets/images/unit02/Wien_displacement_law.png">
</p>

where (&lambda;) is the wavelength of the maximum intensity and (&Tau;) is the absolute temperature (in Kelvin) of the emitting body. This law describes why the temperature (&Tau;) is responsible for the shifted peaks in the above graphic.

### Sensor types
Taken from BSc [remote sensing](https://geomoer.github.io/moer-bsc-project-seminar-remote-sensing/unit04/unit04-02_sensor_types.html)

![image](../assets/images/unit02/satellite_reflectance.png)
*Image: Satellite reflectance. Hanna Meyer and Thomas Nauss [CC BY-NC 4.0] via [uni-marburg.de](https://ilias.uni-marburg.de/ilias.php?ref_id=1652369&obj_id=195392&cmd=layout&cmdClass=illmpresentationgui&cmdNode=g5&baseClass=ilLMPresentationGUI)*

### Passive Sensors
The most common remote sensing imagery comes from passive multispectral sensors. These sensors pick up the natural light from the sun and its reflectance from the Earth's surface. The images are similar to an ordinary photograph with a digital camera and consist of different channels for particular wavelengths. Most multispectral platforms have at least three spectral channels (red, green, blue aka RGB) and a maximum of twelve spectral channels. Hyperspectral sensors take this to the next level and consist of over 100 channels for different wavelengths.

### Active Sensors
Active sensors emit their radiation by themselves. This makes them less dependent on environmental conditions, such as the angle of the sun. The long wavelengths of a radar sensor, for example, can penetrate through clouds, which makes the imagery more consistent. In later units we will see how LiDAR data works and what information can be retrieved from it.


|   | Passive sensors                             |   | Active sensors                                          |   |
|---|---------------------------------------------|---|---------------------------------------------------------|---|
|   | *Natural radiation source*                  |   | *Artificial radiation source*                           |   |
|   | Solar radiation <br/> Terrestrial radiation |   | LiDAR <br/> Radar                                       |   |
|   | *Broad spectrum*                            |   | *Broad spectrum*                                        |   |
|   | UV/VIS/NIR/TIR <br/> MW                     |   | 532 nm / 1064 nm <br/> K, X, C, L, P band (0.8...100cm) |   |



### Electromagnetic radiation

Natural sunlight (solar radiation) is
  * reflected
  * absorbed
  * scattered
  * transmitted

![image](../assets/images/unit02/Electromagnetic_spectrum_-eng.svg)
*Image: Electromagnetic Wave Spectrum. Horst Frank / Phrood / Anony - Horst Frank, Jailbird and Phrood [CC BY-SA 4.0] via [wikimedia.org](https://commons.wikimedia.org/w/index.php?curid=3726606#/media/File:Electromagnetic_spectrum_-eng.svg)*


### Reflective properties

Remote sensing is based on measuring the radiation that is reflected or emitted from bodies on Earth's surface. See [Introduction to Remote Sensing](https://seos-project.eu/remotesensing/remotesensing-c01-p06.html) from the SEOS Project for more details.

![image](../assets/images/unit02/reflexionsspektrum.jpg)
*Image: Spectral signatures of soil, vegetation, snow and water. Hanna Meyer and Thomas Nauss [CC BY-NC 4.0] via [uni-marburg.de](https://ilias.uni-marburg.de/ilias.php?ref_id=1652369&obj_id=195392&cmd=layout&cmdClass=illmpresentationgui&cmdNode=g5&baseClass=ilLMPresentationGUI)*

## Sensor properties

### Spectral resolution

![image](../assets/images/unit02/satellite_spectrum.jpg)
*Image: Spectral resolution of currently available optical satellite sensors. Hirschmugl, M.; Sobe, C.; Khawaja, C.; Janssen, R.; Traverso, L. Pan-European Mapping of Underutilized Land for Bioenergy Production. Land 2021, 10, 102. [CC BY 4.0] via [mdpi.com](https://www.mdpi.com/2073-445X/10/2/102#)*


### Spatial resolution
Spatial resolution is familiar to us all. This is the resolution or how "sharp" a screen is, whether it be a TV, camera or computer screen. The reason that an image appears sharp or fuzzy is the number of pixels in the display -- the greater the number of pixels, the sharper the image. 

![image](../assets/images/unit02/spatial_resolution.png)
*Image: Fuzzy and sharper image of the same landscape. Hanna Meyer and Thomas Nauss [CC BY-NC 4.0] via [uni-marburg.de](https://ilias.uni-marburg.de/ilias.php?ref_id=1652369&obj_id=195392&cmd=layout&cmdClass=illmpresentationgui&cmdNode=g5&baseClass=ilLMPresentationGUI)*


### Temporal resolution

![image](../assets/images/unit02/orbit_velocities.png)
*Image: Altitude determines the orbital speed of a satellite. NASA [CF] via [NASA Earth Observatory](https://earthobservatory.nasa.gov)*

## Satellite systems

The following table contains information about satellite data that is often used in remote sensing applications. Data from all of the listed satellites is freely available to download. These sensors also cover the portion of the electromagnetic spectrum that are useful for observing Earth's surface and changes to it.

|   | Satellite / Sensor            | Start | Spatial resolution | Temporal resolution |
|---|-------------------------------|-------|:------------------:|:-------------------:|
|   | Landsat Multispectral Scanner | 1972  | 80m                | ~2 weeks            |
|   | Landsat Thematic Mapper       | 1982  | 30m                | ~2 weeks            |
|   | Landsat 7                     | 1999  | 30m                | ~2 weeks            |
|   | Landsat 8                     | 2013  | 30m                | ~2 weeks            |
|   | Sentinel-2                    | 2015  | 10-20m             | ~1 week             |
|   | MODIS Terra/Aqua              | 1999  | 250-1000m          | 4x / day            |


## Further reading / additional resources

* Jensen, J. R. 2007: Remote Sensing of the Environment: An Earth Resource Perspective. Pearson/Prentice Hall, 608pp. ISBN-10: 0131889508
* Lillesand, T. M., Kiefer, R. W., & Chipman, J. W. 2008: Remote Sensing and Image Interpretation. Wiley & Sons, 768pp. ISBN-10: 0470052457
* NASA's Earth Observing System Data and Information System ([EOSDIS](https://earthdata.nasa.gov/))
* NASA's [Earth Observatory](http://earthobservatory.nasa.gov/)

