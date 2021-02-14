#!/bin/bash
FILE=/home/ubuntu/app/index.js
if test -f "$FILE"; then
   echo "$FILE exists., so trying again"
   cd /home/ubuntu/app
   pm2 stop --silent index.js
else 
    echo "$FILE does not exist."
fi