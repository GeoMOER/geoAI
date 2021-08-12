---
title: EX | Unet image segmentation
toc: true
header:
  image: /assets/images/unit04/treppe.jpg
  image_description: "Escalator in subway station"
  caption: "Image: ```*snowwhite*``` [CC BY-NC-SA 2.0] [via flickr.com](https://www.flickr.com/photos/101269238@N08/50408950422/)"
---

Deep learning and spatial patterns
In dieser Übung werden wir räumliche Strukturen mit einem U-Net ermitteln. Wir werden versuchen die Anzahl an Autos in einem Dorf in NRW zu ermitteln.

Autos beeinflussen die Umwelt und das Habitat

* Lärm
* Abgase
* Steinkautz
* Verkehrsplannung
* idontknow


<!--more-->

## Detection of cars in a village

We will use the slightly changed model of ????. Please download the already labeled training data as well as the original DOP. 

```python
from model import *
from data import *

data_gen_args = dict(rotation_range=0.2,
                    width_shift_range=0.05,
                    height_shift_range=0.05,
                    shear_range=0.05,
                    zoom_range=0.05,
                    horizontal_flip=True,
                    fill_mode='nearest',
                    brightness_range=[0.4,1.6])
myGene = trainGenerator(2,'data/fairy/train','1','labels',data_gen_args,save_to_dir = None,image_color_mode="rgb")
model = unet(input_size = (256,256,3))
model_checkpoint = ModelCheckpoint(f'model.hdf5', monitor='loss',verbose=1, save_best_only=True)
model.fit_generator(myGene,steps_per_epoch=200,epochs=10,callbacks=[model_checkpoint])
```