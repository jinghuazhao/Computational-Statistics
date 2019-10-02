# Web-related notes

## file synchronisation and permissions for web site

One can employ `rsync` to synchronise the working node to the web space,
```bash
rsync -avrzP $HOME/public_html shell.srcf.net:/public/$HOME
```

Then the permission can set at the web space, e.g.,
```bash
chmod -R +r /public/home/$USER/public_html
find /public/home/$USER/public_html -type d -exec chmod +x {} \;
```

## non-interactive authentication

Both approaches below require `lftp` which is also associated with `libreadline.so.6`.

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
mirror --parallel=15 --log=/home/$USER/work/ftp.log --verbose
bye
END
```

### sftp

```bash
#!/bin/sh

HOST=
USER=
PASS=

echo "Starting to sftp..."

lftp -u ${USER},${PASS} sftp://${HOST} <<EOF
cd jps
lcd /home/${USER}/U/Downloads/
put *
bye
EOF
```
