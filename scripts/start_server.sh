#!/bin/bash
cd /home/ubuntu/app
pm2 start index.js -f
pm2 restart index.js