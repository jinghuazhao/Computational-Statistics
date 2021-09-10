#!/usr/bin/bash

function github_only()
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

function github_pages()
{
  module load python/3.7
  source ~/COVID-19/py37/bin/activate
  pip install mkdocs-mermaid2-plugin
}

github_pages
mkdocs build
mkdocs gh-deploy

git add .gitignore
git add docs
git add mkdocs.yml
git commit -m "backup"
git push
