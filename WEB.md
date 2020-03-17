# Web-related notes

## file synchronisation and permissions for web site

We can employ `rsync` to synchronise the working node to the web space, e.g.,
```bash
rsync -avrzP $HOME/public_html shell.srcf.net:/public/$HOME
```
Then we set the file permissions at the web space, e.g.,
```bash
chmod -R +r /public/home/$USER/public_html
find /public/home/$USER/public_html -type d -exec chmod +x {} \;
```
Note that the synchronisation works equally well for backup of files locally.

## Sophisticated file transfer program

Non-interactive authentication for both `ftp` and `sftp` can be anabled by`lftp`, which can be installed with
```bash
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

### Web site file permission

The following commands set read permission to a web site hosted at `/public/$HOME/public_html`.
```bash
chmod -R +r /public/$HOME/public_html
find /public/$HOME/public_html -type d -exec chmod +x {} \;
```

### Mobile tethering

See information from here,

https://ee.co.uk/help/help-new/network-and-coverage/tethering-or-sharing-internet/how-do-i-share-my-devices-data-connection-through-a-personal-hotspot-or-tethering.
