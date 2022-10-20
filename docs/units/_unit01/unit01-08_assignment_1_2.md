--- 
title: A | Assignment unit 01-2
toc: true
header:
  image: /assets/images/01-splash.jpg
  image_description: "Dr. John Snow's map"
  caption: "Map: [**Dr. John Snow**](https://en.wikipedia.org/wiki/John_Snow) [Wellcome Library via wikimedia](https://w.wiki/QtV)"
---



Now that we've covered some basics, it's time to practice on your own. The following tasks serve as an orientation framework for practicing in a targeted manner. It requires you to solve some technical, content-related and conceptual problems. Let's go.

At Robert Hijmans' `raster` [homepage](https://rspatial.org/raster/index.html#) you will find a lot of straightforward exercises, including our basic examples from before. Robert also provides the necessary data. Another highly recommend place is [Geocomputation with R](https://geocompr.robinlovelace.net) by Robin Lovelace, Jakub Nowosad and Jannes Muenchow. It is *the* outstanding reference and a perfect starting point for everything related to spatio-temporal data analysis and processing with `R`. 

A good approach to improving your skills is to dive into these kind of exercises and use your own data in place of the example data.
This means:
1. Do the exercises with the example data (technical base check)
1. Do the exercises with your own data  (advanced technical base check)
1. Understand the operation

It is a good habit to document what you learn (the knowledge you gain) and any open questions you may have as well as problems that arise. Documenting your progress in an `Rmarkdown` document is particularly useful for this purpose. The `blogdown` package is, in fact, excellent for this. The key is practice: not just getting sample source code to run, but changing it and understanding what it does. 
{: .notice--info}

Please do the following exercises using either the Marburg buildings or the Sentinel-2 dataset. 


{% capture Assignment-1-2 %}
1. Read and operate the following chapters: 
* [Geographic data in R](https://geocompr.robinlovelace.net/spatial-class.html)
* [Spatial data operations](https://geocompr.robinlovelace.net/spatial-operations.html#spatial-operations)
2. Read and work through Robert Hijmans' page about [unsupervised classification](https://rspatial.org/raster/rs/4-unsupclassification.html#unsupervised-classification). Follow his guidelines. 
Instead of the example data from Robert's tutorial, please use either the Sentinel data or the DOP data (not both).
Since you will not find sufficient water areas in the data (unlike in Roberts' example) you can combine the vegetation-covered classes and the vegetation-free classes.


Put your results -- both the classified images and your code -- in a `Rmarkdown` file and convert it to a PDF document. Remember to use the course setup structure!
If you experienced any problems or there were ambiguities in the implementation, please document them in a comprehensible way.

Please upload this PDF file to ILIAS.

Hint: If you need help with `Rmarkdown`, have a look at [R Markdown Quick Tour
](https://rmarkdown.rstudio.com/authoring_quick_tour.html)
{: .notice--info}
{% endcapture %}
<div class="notice--success">
  {{ Assignment-1-2 | markdownify }}
</div> 


## Comments?
You can leave comments under this gist if you have questions or comments about any of the code chunks that are not included as gist. Please copy the corresponding line into your comment to make it easier to answer the question. 



<script src="https://utteranc.es/client.js"
        repo="GeoMOER/geoAI"
        issue-term="GeoAI_2022_unit_01_assignment_1_2"
        theme="github-light"
        crossorigin="anonymous"
        async>
</script>
