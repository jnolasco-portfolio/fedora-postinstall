#!/bin/bash

LOGIN=$1
NEW_ID=$2

OLD_ID=$(id -u $LOGIN)
OLD_GID=$(id -g $LOGIN)

if [[ -z "$OLD_ID" ]]; then
   echo "No se pudo determinar id"
   exit 1
fi

if [[ -z "$OLD_GID" ]]; then
   echo "No se pudo determinar gid"
   exit 1
fi

sudo usermod -u $NEW_ID $LOGIN
sudo groupmod -g $NEW_ID $LOGIN
sudo find / -user $OLD_ID -exec chown -h $NEW_ID {} \;
sudo find / -group $OLD_GID -exec chgrp -h $NEW_ID {} \;
sudo usermod -g $NEW_ID $LOGIN
