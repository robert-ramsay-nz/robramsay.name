#!/bin/sh

if [ "$1" = "--run-once" ] ;then
   # Commands
   haml ./index.haml > ../index.html
   haml ./about.haml > ../index.html

   rsync -ai a.html ../a.html

   scss stylesheets/a.css.scss > ../stylesheets/a.css
   rsync -ai ./css/ ../css/

   rsync -ai ./images/ ../images/

   echo "site updated."
   exit
fi

# Run on startup
$0 --run-once

# Files to watch
filewatcher ./index.haml  ./images/*  ./css/*  "$0 --run-once"
