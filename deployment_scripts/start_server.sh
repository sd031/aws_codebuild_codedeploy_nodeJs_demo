#!/bin/bash
cd /home/ubuntu/app
NODE_ENV=production pm2 start index.js -f