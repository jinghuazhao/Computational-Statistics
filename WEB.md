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

`lftp` enables non-interactive authentication for both `ftp` and `sftp`, which can be installed with
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
open '$FTPURL'
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
