#!/bin/sh

if [ "$1" = "--run-once" ] ;then
   # Commands
   haml ./index.haml > ../index.html
   echo "html generated."
   rsync -ai ./css/ ../css/
   rsync -ai ./images/ ../images/

   exit
fi

# Run on startup
$0 --run-once

# Files to watch
filewatcher ./index.haml  ./images/*  ./css/*  "$0 --run-once"
