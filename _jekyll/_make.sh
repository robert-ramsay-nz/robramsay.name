#!/bin/sh


test -e "_site/.git"    && echo "failure _site/.git/ exists" &&  exit -2
test -e "_site/_jekyll" && echo "failure _site/_jeckyll/ exists" && exit -2


# Generate _site
jekyll || exit -1
echo


# Clean out parent dir.
for i in ../* ; do 
   if [ "$i" != "../_jekyll" ]; then
      rm -rf "$i" 
   fi
done


# Populate with new _site
cd _site
mv * ../../


