---
title: LM | Deeply Good
toc: true
header:
  image: /assets/images/unit04/treppe.jpg
  image_description: "Escalator in subway station"
  caption: "Image: ```*snowwhite*``` [CC BY-NC-SA 2.0] [via flickr.com](https://www.flickr.com/photos/101269238@N08/50408950422/)"
---


In this learning module we focus on the prediction of spatial structures. With the random forest model we could achieve good predictions on a pixel level. However, when we try to recognize spatial structures, not only the value of a single pixel is interesting, but also its neighbouring pixels. Deep learning neural networks are a suitable tool for recognizing such structures.
<!--more-->
## Deep Learning in a nutshell

If this is your first encounter with deep learning, here follows a brief introduction to the world of neurons. If you are already familiar with the concept of deep learning neural networks you can go directly to the [U-Net](#u-net) section.

<p align="center">
  <img width="300" height="300" src="../assets/images/unit04/deep_learning_image.png" alt="drawing">
</p>

Deep learning algorithms as well as random forest models belong to the machine learning tools. They are a special form of neural networks.
They are used especially frequently in image recognition.

Video here: 

{% include pdf pdf="03-02_randomly_good.pdf" %}


## U-Net




![image](../assets/images/unit04/Example_architecture_of_U-Net.png)
*Image: Example architecture of U-Net for producing k 256-by-256 image masks for a 256-by-256 RGB image. Mehrdad Yazdani [CC BY-SA 4.0] via [wikipedia.org](https://en.wikipedia.org/wiki/U-Net#/media/File:Example_architecture_of_U-Net_for_producing_k_256-by-256_image_masks_for_a_256-by-256_RGB_image.png)*

[Ronneberger et al. (2015) U-Net: Convolutional Networks for Biomedical Image Segmentation](https://arxiv.org/abs/1505.04597)


[5 Minute Teaser Presentation of the U-net: Convolutional Networks for Biomedical Image Segmentation (5:03)](https://www.youtube.com/watch?v=81AvQQnpG4Q){:target="_blank"} 


