#!/bin/sh

git checkout gh-pages

git ls-files -z | xargs -0 git rm
gco HEAD -- CNAME .gitignore

rsync -a _public/ .
cd _public
find . -type f -exec git add ../{} \;
cd ..

git commit -m "$(git log -1 --format="%B%n(%h)" source)"

git checkout source

