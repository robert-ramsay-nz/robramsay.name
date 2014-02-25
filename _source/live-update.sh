#!/bin/sh

if [ "$1" = "--run-once" ] ;then
   # Commands
   haml ./index.haml > ../index.html
   rsync -ai ./css/ ../css/
   rsync -ai ./images/ ../images/

   echo "site updated."
   exit
fi

# Run on startup
$0 --run-once

# Files to watch
filewatcher ./index.haml  ./images/*  ./css/*  "$0 --run-once"
