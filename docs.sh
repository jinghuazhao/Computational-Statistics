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
  module load python/3.8
  source ~/rds/public_databases/software/py38/bin/activate
# pip install mkdocs-mermaid2-plugin
}

if [ "$(uname -n | sed 's/-[0-9]*$//')" == "login-q" ]; then
   module load ceuadmin/libssh/0.10.6-icelake
   module load ceuadmin/openssh/9.7p1-icelake
   module load ceuadmin/krb5
fi

# cclake
# export LD_PRELOAD=/usr/lib64/libcrypto.so.1.1
github_pages
mkdocs build
mkdocs gh-deploy

git add .gitignore
git add docs
git add mkdocs.yml
git commit -m "backup"
git push
