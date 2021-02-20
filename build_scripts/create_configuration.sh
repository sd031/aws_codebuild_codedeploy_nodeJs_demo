#!/bin/bash
#//rm -rf ./config/production.json
#touch ./config/production.json
json -I -f ./config/production.json \
      -e "this.DB_HOST='LOCALHOST'" \
      -e "this.DB_URL='USERNAME'" \
      -e "this.DB_PASSWORD='PASSWORD'"