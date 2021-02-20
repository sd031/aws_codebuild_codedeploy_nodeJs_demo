#!/bin/bash
CONFIG_PATH=./config/production.json
echo Check Below
echo $CONFIG_PATH
rm -rf $CONFIG_PATH
echo "{}" >> $CONFIG_PATH
echo $PWD
json -I -f $CONFIG_PATH \
      -e "this.DB_HOST='$DB_HOST'" \
      -e "this.DB_USERNAME='$DB_USERNAME'" \
      -e "this.DB_PASSWORD='$DB_PASSWORD'"