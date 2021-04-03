# Web-related notes

## wget

A useful instance is as follows,
```bash
wget -nd --execute="robots = off" --mirror --convert-links --no-parent --wait=5 http://ftp.ebi.ac.uk/pub/databases/spot/eQTL/csv/GTEx_V8/ge/
```

## Sophisticated file transfer program

Non-interactive authentication for both `ftp` and `sftp` can be anabled by`lftp`, which can be installed with
```bash
# Fedora
sudo dnf install lftp
# Ubuntun
sudo apt install lftp
```
Note in both cases command delimiters are required.

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

### djvulibre

```bash
wget https://github.com/barak/djvulibre/archive/debian/3.5.27.1-14.zip
unzip  3.5.27.1-14.zip |more
cd djvulibre-debian-3.5.27.1-14/
./autogen.sh
configure --prefix=/rds-d4/user/jhz22/hpc-work/
make
make install
```

### Google-chrome

Installation is possible with
```bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
```
then the Google repository is also added.

### Mobile tethering

See information from here,

https://ee.co.uk/help/help-new/network-and-coverage/tethering-or-sharing-internet/how-do-i-share-my-devices-data-connection-through-a-personal-hotspot-or-tethering.

### Google document and EndNote

It is possible to insert citation from an EndNote library, download as RTF more preferably OpenDocument format, and recover the citations through Tools --> Format paper, e.g.,

https://libguides.jcu.edu.au/endnote/google-docs

### sphinx

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

### Web site file permission

The following commands set read permission to a web site hosted at `/public/$HOME/public_html`.
```bash
chmod -R +r /public/$HOME/public_html
find /public/$HOME/public_html -type d -exec chmod +x {} \;
```
