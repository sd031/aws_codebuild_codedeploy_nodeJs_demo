#!/bin/bash
FILE=/home/ubuntu/app/index.js
if test -f "$FILE"; then
   pm2 stop --silent index.js
fi