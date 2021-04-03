#!/usr/bin/bash

function old()
{
  git add README.md
  git commit -m "README"
  for d in INSTALL.md LANGUAGES.md PARALLEL.md REPRODUCE.md SYSTEMS.md WEB.md
  do
     git add $d
     git commit -m "$d"
  done
  git add src
  git commit -m "source programs"
  git push
}

module load python/3.7
source ~/COVID-19/py37/bin/activate
mkdocs build
mkdocs gh-deploy
git add docs
git add mkdocs.yml
git commit -m "backup"
git push
