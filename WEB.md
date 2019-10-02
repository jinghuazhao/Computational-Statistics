# Web-related notes

## non-interactive authentication

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
lcd /home/jhz22/U/Downloads/
put *
bye
EOF
```

## file permissions for web site

The permission needs to be set, e.g.,
```bash
chmod -R +r /public/home/$USER/public_html
find /public/home/$USER/public_html -type d -exec chmod +x {} \;
```
