# Web-related notes

## aria2

Web: [https://aria2.github.io/](https://aria2.github.io/).

The first example, `aria2c -c -j10 -i ../urls.txt`, specifies that to continue (-c) interrupted download, to use 10 concurrent threads (-j10) and use links in `urls.txt`.

The second example uses - as input: `echo https://download.decode.is/s3/download?token=68278faa-0b69-47a0-8fcb-5e7f4057004d&file=10023_32_VDR_VDR.txt.gz | aria2c -i -`.

## wget

Some useful instances are as follows,
```bash
wget -nd --execute="robots = off" --mirror --convert-links --no-parent --wait=5 http://ftp.ebi.ac.uk/pub/databases/spot/eQTL/csv/GTEx_V8/ge/
wget --no-check-certificate https://omicscience.org/apps/pgwas/data/all.grch37.tabix.gz
wget --no-check-certificate https://omicscience.org/apps/pgwas/data/all.grch37.tabix.gz.tbi
```

## lftp

This is a sophisticated file transfer program.

Non-interactive authentication for both `ftp` and `sftp` can be enabled by `lftp`, which can be installed with
```bash
# Fedora
sudo dnf install lftp
# Ubuntun
sudo apt install lftp
```
Note in both cases command delimiters are required.

Usage example: `lftp -c mirror https://ftp.ebi.ac.uk/pub/databases/gwas/summary_statistics/GCST90086001-GCST90087000/`.

### ftp

```bash
#!/bin/bash

HOST=
USER=
PASS=
FTPURL="ftp://$USER:$PASS@$HOST"
LCD=
RCD=

lftp $HOST <<END
set ftp:list-options -a;
open '$FTPURL';
lcd $LCD;
cd $RCD;
mirror --parallel=15 --log=/home/$USER/work/ftp.log --verbose;
bye;
END
```
Note to put files is possible with -R option.

### sftp

```bash
#!/bin/bash

HOST=
USER=
PASS=

cd /home/${USER}/U/Downloads
lftp -u ${USER},${PASS} sftp://${HOST} <<EOF
cd jps;
put *;
bye;
EOF
```

the following error
> Unable to negotiate with xxx.xxx.xxx.xxx port 22: no matching key exchange method found. Their offer: diffie-hellman-group-exchange-sha1,diffie-hellman-group14-sha1,diffie-hellman-group1-sha1

can be fixed with ssh/sftp as follows,
```bash
sftp -oKexAlgorithms=+diffie-hellman-group1-sha1 user@host
```

## dash

This illustrates under Ubuntu 21.10 the demo `dash-drug-discovery`, [https://dash.gallery/dash-drug-discovery/](https://dash.gallery/dash-drug-discovery/).

```bash
sudo apt install python3.9-venv
python3 -m venv myvenv
source myvenv/bin/activate
pip install pandas
pip install dash
pip install gunicorn
unzip dash-drug-discovery.zip
cd dash-drug-discovery
python app.py
firefox http://127.0.0.1:8050
```

The zip file is available from [https://github.com/plotly/dash-sample-apps/releases](https://github.com/plotly/dash-sample-apps/releases).

A detailed example for instance can be seen from [https://realpython.com/python-dash/](https://realpython.com/python-dash/).

The simplest version is R is done as follows,

```r
library(dash)
app <- dash_app()

app %>% set_layout("hello", "Dash")
app %>% set_layout(div("hello"), "Dash")
app %>% set_layout(list(div("hello"), "Dash"))
app %>% set_layout("Conditional UI using an if statement: ",
                   if (TRUE) "rendered",
                   if (FALSE) "not rendered")
app %>% set_layout(function() { div("Current time: ", Sys.time()) })
app
```

The `dash` package is available from [https://CRAN.R-project.org/package=dash](https://CRAN.R-project.org/package=dash).

## djvulibre

```bash
wget https://github.com/barak/djvulibre/archive/debian/3.5.27.1-14.zip
unzip  3.5.27.1-14.zip |more
cd djvulibre-debian-3.5.27.1-14/
./autogen.sh
configure --prefix=/rds-d4/user/jhz22/hpc-work/
make
make install
```

## Google-chrome

Installation is possible with
```bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
```
then the Google repository is also added.

### Mobile tethering

See information from here,

https://ee.co.uk/help/help-new/network-and-coverage/tethering-or-sharing-internet/how-do-i-share-my-devices-data-connection-through-a-personal-hotspot-or-tethering.

## locale

This is an example to convert from French encoding,

```bash
#!/usr/bin/bash

if [ ! -d ascii ]; then mkdir ascii; fi
cd ascii
echo $LANG
export LANG=en_US.utf8
iconv  -c -f UTF-8 -t "ASCII//TRANSLIT" ../"Data Graph Categorization.csv" > "Data Graph Categorization.csv"
iconv  -c -f UTF-8 -t "ASCII//TRANSLIT" ../"Data Graph Coverage Text Books 1980-2016.csv" > "Data Graph Coverage Text Books 1980-2016.csv"
iconv  -c -f UTF-8 -t "ASCII//TRANSLIT" ../"Data Graph Features.csv" > "Data Graph Features.csv"
iconv  -c -f UTF-8 -t "ASCII//TRANSLIT" ../"R Code Data Analyses.R" > "R Code Data Analyses.R" # needs comment on -prev_p[order(-prev_p[,3]),]
iconv  -c -f UTF-8 -t "ASCII//TRANSLIT" ../"R Code Figures.R" > "R Code Figures.R"
R --no-save < "R Code Data Analyses.R"
R --no-save < "R Code Figures.R"
cd -
```

as in the following paper,

Kossmeier et al. Charting the landscape of graphical displays for meta-analysis and systematic reviews: a comprehensive review, taxonomy, and feature analysis. BMC Medical Research Methodology (2020) 20:26, https://doi.org/10.1186/s12874-020-0911-9

Perhaps a somewhat easier way to do is through RStudio's `File` --> `Save with Encoding` and choose `UTF-8`.

### Google document and EndNote

It is possible to insert citation from an EndNote library, download as RTF more preferably OpenDocument format, and recover the citations through Tools --> Format paper, e.g.,

https://libguides.jcu.edu.au/endnote/google-docs

## sphinx

The sequence below follows,  https://docs.readthedocs.io/en/stable/intro/getting-started-with-sphinx.html.
```bash
module load python/3.6
virtualenv --system-site-package venv
source venv/bin/activate
pip install sphinx
mkdir docs
cd docs
sphinx-quickstart
make html
pip install recommonmark
```

## Synchronisation

We can employ `rsync` to synchronise the working node to the web space, e.g.,
```bash
rsync -avrzP $HOME/public_html shell.srcf.net:/public/$HOME
```
Note that it works equally well for backup of files locally.

## Web site file permission

The following commands set read permission to a web site hosted at `/public/$HOME/public_html`.
```bash
chmod -R +r /public/$HOME/public_html
find /public/$HOME/public_html -type d -exec chmod +x {} \;
```
