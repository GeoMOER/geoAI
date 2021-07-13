---
title: Jekyll and GitHub pages
header:
  image: /assets/images/02-splash.jpg
  image_description: "Cutout from  Measured carbon dioxide concentrations in Vancouver"
  caption: "Bild: [jekyll](https://jekyllrb.com/)"
---


Getting started with your own GitHub page using Jekyll and Minimal Mistakes. Das Erstellen von GitHub pages mithilfe von Jekyll ermöglicht es dir schnell, einfach und (hoffentlich) unkomliziert eine eigene Website zu bauen, mit deren Hilfe du deine Ergebnisse schön präsentieren kannst.

<!--more-->
# zu Jekyll
Jekyll ermöglicht es dir mithilfe von Markdown files tolle Websites zu erstellen...

# zu GitHub pages
Du kannst deine mit Jekyll erstellte Seite einfach auf GitHub hosten...



# Prerequisites


1. Install the latest version of the rubygems with devkit 64
  - https://rubyinstaller.org/downloads/
  - Restart the computer afterwards, just to make sure, especially if you are under Windows.

2. Install bundler from terminal: "gem install bundler" 
  - The path does not matter where you execute it
  - Close and restart the terminal to update the PATH Variables (otherwise the gem function is not available). If this does not work, restart the computer, especially if you are under Windows.

3. Check if you have all other prerequisites installed (if any), here:
    https://jekyllrb.com/docs/
-	Gcc installiert mit: https://dev.to/gamegods3/how-to-install-gcc-in-windows-10-the-easier-way-422j
-	Make installieren: 
-	Windows cmd: copy c:\MinGW\bin\mingw32-make.exe c:\MinGW\bin\make.exe


4. Get a "docs" folder in your GitHub repository, which follows the required Jekyll structure (assets, _data, _includes, _pages, etc.)
  - Check here for details: 
  - You can also use a template like https://github.com/GeoMOER/moer-html-module-template

5. Run "bundle install" in this "docs" folder (switch to /docs folder before in the terminal) for installing the required gems for your webpage.
 - the gems will be installed in your local repository folder. If you want, and often you should want, exclude them from synchronizing with GitHub by adding the ".bundle" or "vendor" folders to your 	 file

<!--more-->

