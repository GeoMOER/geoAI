---
title: A | Assignment unit 02-1
toc: true
header:
  image: /assets/images/unit02/31031723265_0890cd9547_o.jpg
  image_description: "Cloudscape Over the Philippine Sea"
  caption: "Image: [NASA's Marshall Space Flight Center](https://www.nasa.gov/centers/marshall/home/index.html) [CC BY-NC 2.0] via [flickr.com](https://www.flickr.com/photos/nasamarshall/31031723265/)"
---




To be defined.


## Assignment
This exercise will prepare the polygon data that is necessary to predict buildings in Marburg, Hesse. Please follow along with the example of creating a vector layer of buildings in QGIS. Remember to save your data in the appropriate folder from the setup in Unit 1!

### Creating vector layers in QGIS
We will use the open source GIS QGIS to create training areas. In this course, we will use the current long-term release (as of October 2021), QGIS 3.16.11 Hanover. You can download QGIS either as a [standalone version](https://qgis.org/en/site/forusers/download.html) or using OSGeo4w.

First, open QGIS and in the "Browser" panel on the upper left-hand side, navigate to the geoAI project data folder. Double click on `marburg_dop.tif` to add the TIF as a layer in the project. You will see it appear in the lower left-hand panel "Layers". You can also drag the layer from the "Browser" panel and drop it into the "Layers" panel.

{% include figure image_path="/assets/images/unit02/step1_import.png" alt="Import TIF into QGIS" %}

The imported TIF is now part of the current project and QGIS displays its contents -- in this case, the southern part of Marburg including the Stadtwald and the Heiliger Grund.

Next, we need to create a new GeoPackage layer, in which we will save the polygons that we draw. We can create the layer in multiple ways. In the menu bar, click on "Layer" > "Create Layer" > "New GeoPackage Layer". Alternatively, you can open the "Data Source Manager" from the "Layer" menu and create a new GeoPackage layer from that window.

{% include figure image_path="/assets/images/unit02/step2_create_gpkg_layer.png" alt="Create new GeoPackage layer" %}

In the "New GeoPackage Layer" window, give your new GeoPackage a name in the Database field. You also need to assign a name to the Table. Next, select the geometry type -- in this case "Polygon" because we want to create polygons. Then select the CRS for the layer. We want our polygons to have the same CRS as our DOP, so we select the option that begins with "Project CRS:". Finally, we have the option to add fields. Every polygon will have some unique attributes that will appear in the Attribute Table. We can use the attributes of a polygon (or any other geometry) to filter. It's important to think of generic categories for the fields, because they will be headers of columns and each polygon will be an entry in the table. In this example, we have chosen "Region" and "class" for our polygons, both of type text and length 20. To create the Layer, click OK. 

The category in the "class" field is particularly important for the prediction that we will make in Unit 3. Create polygons with two categories of "class": one class in which you assign the value "building" to the digitized houses and another class in which you digitize various other aspects of the space (these polygons should have the value "other"). Try to mix your polygons well in this category, i.e. include roads, cars, houses, water, fields, meadows and forest, in order to represent as broad of a spectrum as possible.
{: .notice--info}

Then, we need to toggle editing on for the Buildings layer. Right click on the Buildings layer in the Layer panel and select "Toggle editing". You also have the button to toggle editing on in the toolbar, if you have the Digitizing toolbar enabled ("View" > "Toolbars" > "Digitizing Toolbar"). 

{% include figure image_path="/assets/images/unit02/step3_toggle_editing.png" alt="Toggle editing on" %}

After that, we click the Add Polygon Feature button in the Digitizing toolbar. Notice that your mouse cursor has become a crosshair to place the points more accurately. Remember that when using the digitizing tool, you can still zoom in and out by rolling the mouse wheel. Now, we can begin adding polygons to our Buildings GeoPackage.

Start by left clicking on a point somewhere along the edge of a building's rooftop. Left click along the edges of that rooftop to place more points until the shape that you have drawn completely covers the rooftop.

{% include figure image_path="/assets/images/unit02/step4_draw_polygon.png" alt="Draw first polygon" %}

After you place your last point, right click to finish drawing the polygon. This will finalize the feature and open the Feature Attributes dialogue menu. Here, you can assign the characteristics of that polygon to it -- in this case, the polygon is located in the region "Marburg-Biedenkopf" and belongs to the class "building".

{% include figure image_path="/assets/images/unit02/step5_assign_attributes.png" alt="Fill in attribute entries" %}

Complete this process for as much of the area as you can. Once you're done with the digitizing process, remember to save the edits to your layer by clicking the "Save Layer Edits" button in the toolbar. Then, toggle off editing for that layer. Now that you're done, you can see the results by opening the layer's attribute table.

{% include figure image_path="/assets/images/unit02/step6_open_attribute_table.png" alt="View attribute table" %}

Congratulations, you've hand-drawn and digitized your first set of training areas! This step is important for the machine learning algorithms that we will use in the next unit.





## Comments?
You can leave comments under this gist if you have questions or comments about any of the code chunks that are not included as gist. Please copy the corresponding line into your comment to make it easier to answer the question. 



<script src="https://utteranc.es/client.js"
        repo="GeoMOER/geoAI"
        issue-term="GeoAI_2022_unit_02_assignment_2_1"
        theme="github-light"
        crossorigin="anonymous"
        async>
</script>
