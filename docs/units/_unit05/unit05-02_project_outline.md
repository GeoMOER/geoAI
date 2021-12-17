---
title: Project outline
toc: true
published: true
header:
  image: /assets/images/unit05/notebook.jpg
  caption: "Image: Neil Conway [Public Domain Mark 1.0] via [flickr.com](https://www.flickr.com/photos/neilconway/5625707813/in/photostream/)"
 
---
   
Learn more about the requirements for creating a project outline and for the structure, content, and format of your research project.


# Content and structure
The project outline should include
* a title, of course, 
* the authors,
* an introduction outlining the state of the art, research need and relevance of the expected results in the context of your research question,
* a data section describing the intended data you are planning to use,
* a method section with details on the methods you plan to apply on your data for getting an answer to you research question,
* a discussion section, where you discuss the implications, conclusions, potential limitations and improvements, picking up the story you created in the introduction, 
* a timetable with important work packages and milestones you aim to work on for reaching the project goal, and 
* references on relevant scientific papers, which have been published in the context of your research question.

Note that the project outline should not exceed two pages.
These pages will help the instructors to give feedback on especially the feasibility of your project. 

# Where to get data?
After identifying the research question, a critical step is to find or create appropriate data sets for your modeling workflow.
Some data source suggestions are:

## Digital orthophotos Hesse

We can provide you with DOP data for the study area of your research question in Hesse.
Theses data will be provided by the Hessische Verwaltung für Bodenmanagement und Geoinformation.
Therefore, they require the  bounding boxes of your study area as shapefile.
Note that these data inquiries will need several days to process, so please send us your shapefiles in due time.
Please also take into consideration that the file size and hence processing time of the DOPs depends on the selected study area.
As a rough guideline,1GB roughly corresponds to 30km² (40cm resolution, RGBA).


## Digital orthophotos North Rhine-Westphalia
You can also download almost all geodata of North Rhine-Westphalia ([Geoportal NRW](https://www.geoportal.nrw/)) free of charge.
Next to the DOPs there is also the possibility to download some shapefiles which could be used as mask data.
   
   
## Sentinel-2
If your research question focuses on a topic with a larger extent or is out of the boundaries of Hesse/North Rhine-Westphalia, it is presumably required to download your data somewhere else. One possible data source is the Sentinel-2 mission. You already know how to download Sentinel-2 data via the `sen2r-package`.
   
## Other sources
In addition to the above mentioned data sources you can of course freely search for other sources of spatial data, 
like e.g. [Geoportal NRW](https://www.geoportal.nrw/), [OpenStreetMap](https://www.openstreetmap.de/), [Kaggle](https://www.kaggle.com/), etc.

You have also learnt to create your own shapefiles for obtaining training data. 
This could be well necessary if there is no available data set for your (specific) topic.


   



# Feedback
Feedback on the outline will be given at the session on 21.01.2022. On the one hand, it is necessary to submit the outline in time (17.1.2022!), so that there is enough time for the instructors to prepare feedback. On the other hand, the feedback will be given in the session. In order to make the feedback understandable for everyone, your group should briefly present your outline within 5 minutes. No slides are needed, the two-page outline is sufficient.


{% capture Assignment-05-01 %}

# Assignment unit-05-01
Write your project outline. Therefore
1. find your group members and get to know each other,
2. choose a research question,
3. strictly follow the points mentioned under "Content and structure" above,
4. upload your project outline to ILIAS until 17 January 2022 23:59 as one pdf file, and 
5. choose one person for presenting your outline in the session on 21 January 2022.

Again put your outline in an ´Rmarkdown´ file and compile it to a PDF document for upload on ILIAS.

{% endcapture %}
<div class="notice--success">
  {{ Assignment-05-01 | markdownify }}
</div>   



## Comments?
You can leave comments under this Issue if you have questions or remarks about the assignment. 



<script src="https://utteranc.es/client.js"
        repo="GeoMOER/geoAI"
        issue-term="GeoAI_2021_unit_05_01_project_outline"
        theme="github-light"
        crossorigin="anonymous"
        async>
</script>

