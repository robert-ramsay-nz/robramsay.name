#!/bin/sh

if [ "$1" = "--run-once" ] ;then
   # Commands
   #haml ./index.haml > ../index.html
   #haml ./about.haml > ../about.html
   #haml ./old-index.haml > ../old-index.html

   find . -iname '*.haml' -exec bash -c 'mkdir -p "../$(dirname {})"' \;
   find . -iname '*.haml' -exec bash -c 'haml "{}" > "../$(echo "{}" | sed s/\.haml$// ).html"' \;

   mkdir -p ../testing
   cp testing/*.html ../testing

   mkdir -p ../testing/stylesheets
   for scss_file in testing/stylesheets/*.css.scss ; do 
      css_file="$(echo "$scss_file" | sed s/\.scss$//g)"
      scss "$scss_file" > "../$css_file"
   done

   rsync -ai ./testing/images/ ../testing/images/

   cp *.html ..

   mkdir -p ../stylesheets
   for scss_file in stylesheets/*.css.scss ; do 
      css_file="$(echo "$scss_file" | sed s/\.scss$//g)"
      scss "$scss_file" > "../$css_file"
   done

   rsync -ai ./css/ ../css/

   rsync -ai ./images/ ../images/

   echo "site updated."
   exit
fi

# Run on startup
$0 --run-once

# Files to watch
filewatcher "*.html *.haml images/* stylesheets/* css/*"  "$0 --run-once"
