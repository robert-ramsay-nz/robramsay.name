#!/bin/sh

export BUILDDIR="./_public"

if [ "$1" = "--run-once" ] ;then
   mkdir -p "$BUILDDIR"

   find . -path '*/_*/*' -prune -o -name '*.haml' -exec bash -c 'mkdir -p "$BUILDDIR/$(dirname "{}")"' \;
   find . -path '*/_*/*' -prune -o -name '*.haml' -exec bash -c 'haml "{}" > "$BUILDDIR/$(echo "{}" | sed s/\.haml$// ).html"' \;

   mkdir -p "$BUILDDIR/testing"
   cp testing/*.html "$BUILDDIR/testing"

   mkdir -p "$BUILDDIR/testing/stylesheets"
   for scss_file in testing/stylesheets/*.css.scss ; do 
      css_file="$(echo "$scss_file" | sed s/\.scss$//g)"
      scss "$scss_file" > "$BUILDDIR/$css_file"
   done

   rsync -ai ./testing/images/ "$BUILDDIR/testing/images/"

   cp *.html "$BUILDDIR/"

   mkdir -p "$BUILDDIR/stylesheets"
   for scss_file in stylesheets/*.css.scss ; do 
      css_file="$(echo "$scss_file" | sed s/\.scss$//g)"
      scss "$scss_file" > "$BUILDDIR/$css_file"
   done

   rsync -ai ./css/ "$BUILDDIR/css/"

   rsync -ai ./images/ "$BUILDDIR/images/"

   echo "site updated."
   exit
fi

# Run on startup
$0 --run-once

# Files to watch
filewatcher "*.html *.haml images/* stylesheets/* css/*"  "$0 --run-once"
