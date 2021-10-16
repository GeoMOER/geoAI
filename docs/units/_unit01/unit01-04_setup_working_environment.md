--- 
title: EX | Setting up the course environment 
toc: true
header:
  image: /assets/images/01-splash.jpg
  image_description: "Dr. John Snow's map"
  caption: "Map: [**Dr. John Snow**](https://en.wikipedia.org/wiki/John_Snow) [Wellcome Library via wikimedia](https://w.wiki/QtV)"
---

To set up a working or project environment, the first steps are normally to define different folder paths and load the necessary R packages as well as additional functions. 
<!--more-->
If you also need to access additional software, like GIS, the appropriate binaries and software environments must be linked, too. Factoring in the major operating systems and the potentially multiple versions of software installed on a single system results in almost unlimited combinations of set ups.

## Flexible but reproducible setup

We value freedom of choice as an important good. But given our long-term experience as instructors of similar courses, there is **no freedom of choice** when it comes to the mandatory working environment for this course. The reason for this is simple: Assignments and chunks of code written on person A's laptop should run on person B's computer without requiring any changes. The greater the number of systems that should be able to run the code, the nastier this potential situation can become. So, let's save everyone's time and focus on the things that are really important. Once the course is finished, feel free to use any working environment structure you like.

## R project frameworks
Setting up a working or project environment requires the definition of different folder paths and the loading of necessary R packages and additional functions. If, in addition, external APIs (application programming interface) are to be integrated stably and without great effort, the associated paths and environment variables must also be defined correctly. 

There are several R-packages like e.g. [tinyProject](https://github.com/FrancoisGuillem/tinyProject){:target="_blank"},  [workflowR](https://jdblischak.github.io/workflowr/){:target="_blank"} or [usethis](https://usethis.r-lib.org/){:target="_blank"}  which provide a wide range of functions for such issues. For this entry into a structured organization of R-based development projects, we suggest a slimmed down version. 

## Introduction of the envimaR helper package 
It would be convenient if the *mandantory* folders were automatically created and initialised. For the needs of the course we have written a small project management package called `envimaR` that takes over these tasks. It is located on `github` and can be installed as known.

```r
devtools::install_github("envima/envimaR")
```

Essentially a project may be split in four categories of tasks that have to be handled:

- data 
- scripts
- documentation
- results


The basis of the aforementioned categories is an adequate storage structure on a suitable permanent storage medium (hard disk, USB stick, cloud, etc.). We suggest a meaningful hierarchical directory structure. The root folder of a project is the basis of an organizational structure branched below.



First I want to find out which folder structure can be used sensibly on my system. So the use of the so called `H:` drive on the pool PCs is extremely problematic due to the underlying `dfs//` network assignment and therefore to be avoided. For an automatic query on which computer I am currently working (and therefore which root directory I want to use) use the function `envimaR::alternativeEnvi`. 

```r
require(envimaR)
# define a project rootfolder
rootDir = "~/edu/geoAI"     # This is the mandantory rootfolder of the whole project 

c
              
# call the create function
envimaR::alternativeEnvi(root_folder = rootDir,              # if exist this is the root dir 
                         alt_env_id = "COMPUTERNAME",        # check the environment varialbe "COMPUTERNAME"
                         alt_env_value = "PCRZP",            # if it contains the string "PCRZP" (e.g. PUM-Pool-PC)
                         alt_env_root_folder = "F:/BEN/edu") # use the alternative rootfolder
```


Provided I want to create a project with the mandantory folder structure defined above, checking the PC I am working on, load all packages I need  and store all environment variables in a list for latter use  I may use the `createEnvi` function. To do so I first have to define a list of all packages that I want to load. 

```r
# list of packages to load
packagesToLoad = c("mapview", "raster", "rgdal", "sf", "keras","reticulate")

# Automatically set root direcory, folder structure and load libraries
envrmt = envimaR::createEnvi(root_folder = rootDir,
                             folders = projectDirList,
                             path_prefix = "path_",              # prefix to all path variables that are created 
                             libs = packagesToLoad,                        # list of R-packages that should be loaded
                             alt_env_id = "COMPUTERNAME",        # check the environment varialbe "COMPUTERNAME"
                             alt_env_value = "PCRZP",            # if it contains the string "PCRZP" (e.g. local PC-Pools)
                             alt_env_root_folder = "F:/BEN/edu") # use the alternative rootfolder
                         

```

I will receive something like the following messages. Note even if red colored these are no error messages...


```bash
Loading required package: lidR
Loading required package: raster
Loading required package: sp
lidR 2.1.2 using 2 threads. Help on <gis.stackexchange.com>. Bug report on <github.com/Jean-Romain/lidR>.
Loading required package: link2GI
Loading required package: mapview
Loading required package: rgdal
rgdal: version: 1.4-7, (SVN revision 845)
 Geospatial Data Abstraction Library extensions to R successfully loaded
 Loaded GDAL runtime: GDAL 3.0.1, released 2019/06/28
 Path to GDAL shared files: 
 GDAL binary built with GEOS: TRUE 
 Loaded PROJ.4 runtime: Rel. 6.2.0, September 1st, 2019, [PJ_VERSION: 620]
 Path to PROJ.4 shared files: (autodetected)
 Linking to sp version: 1.3-1 
Loading required package: rlas
Loading required package: uavRst
```

## Wrap it up in a setup script

Finally, some useful settings have to be made. So it makes sense to have the current github versions of the non CRAN packages available and for the `raster` package you should also set an option for temporary actions.

If you put everything together in one script it looks like this:

{% gist a2324e11b4342cbd4da29b0a819b58e6 moc-courses-setup.R%}
[Get moc-courses-setup.R](https://gist.github.com/envimar/a2324e11b4342cbd4da29b0a819b58e6/archive/4e57418e6c645ce09766f7aa6fe2cabb5c431349.zip)

Please *check* the result by navigating to the directory using your favorite file manger. In addition please check the returned `envrmt` list. It contains all paths as character strings in a convenient  list structure.

```r
# traditionally
str(envrmt)

# more fancy
require(listviewer)
listviewer::jsonedit(envrmt)  
```
The script thus provides as intended:

- create/initialize the mandatory basic folder structure 
- create a list variable containing all paths as shortcuts  
- install and initialize all packages and settings for the project

## Install Tensorflow and keras for DL purposes

Please note that while this course is primarily based on R, we also use the programming language Python to supplement R. This is primarily the case in Unit 4, which deals with Deep Learning. The `packagestoLoad` variable in `geoAI_setup.R` includes several Python modules (e.g. `tensorflow`, `keras`) that work in R thanks to the R package `reticulate`.

```r
# install keras & miniconda
reticulate::install_miniconda()
keras::install_keras()
```

That being said, *the implementation is not seamless.* The first time that you run the `moc-courses-setup.R` script, you will likely drink one ore more cups of coffe and receive many errors that need to be worked through. 


{: .notice--warning}

It is **mandantory** to save this script in the `src` folder (e.g. under `geoAI_setup.R`) and source it **before every** start of any analysis script connected with this project. You can do this easily as follows:

```r
source(file.path(envimaR::alternativeEnvi(root_folder = "~/edu/geoAI",
                                       alt_env_id = "COMPUTERNAME",
                                       alt_env_value = "PCRZP",
                                       alt_env_root_folder = "F:/BEN/edu"),
                  "src/geoAI_setup.R"))
```



{% capture Assignment-01-1 %}

Implement and check working environment setup

1. Set up and check the basic working environment as explained above.
1. Check if the installation of `tensorflow` and `keras` was successful. Copy the following script from the vignette "Getting Started with Keras" into the editor and execute it step by step. Compare the results with the vignette. 
{% gist 79a7249aaced24fafd23149b4fb0a81f%}
[Get keras-test.R](https://gist.github.com/envimar/79a7249aaced24fafd23149b4fb0a81f/archive/5fde2a75343ee741c45b29a2ca997f61ec0861e9.zip)
1. Write upload a short error report if it fails and add what you have done so far to solve the problem. Please include also the output of `sessionInfo()`. If everything is fine just write this in the report.


{% endcapture %}

<div class="notice--success">
  <h4 class="no_toc">Assignment 01-11:</h4>
  {{ Assignment-01-1 | markdownify }}
</div> 


## Concluding remarks 

Please note!
Several errors are likely to pop up during this installation and setup process. As you will learn through this entire process of patching together different pieces of software, some error warnings are more descriptive than others. 

This procedure is typical and usually necessary. For complex tasks, external software libraries and tools often need to be landed and connected. Even if most software developers try to facilitate this eye, it is often associated with an interactive and step-by-step approach.


When in doubt (`and before asking your instructor ;-)`), ask Google! Not because we are too comfortable to answer (we will answer you of course) but because as (data) scientists you have to learn to solve these problems. We have all learned this way as well and it is highly unlikely that you are the first person to ask the question -- Especially [StackOverflow](https://stackoverflow.com/questions/tagged/r) is your friend!
{: .notice--info}

