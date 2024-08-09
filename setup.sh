#!/bin/bash
set -e

# check dvinstall directory
if [ ! -d "./dvinstall" ]; then
  echo "'dvinstall' directory not found!"
  echo "You need to download dvinstall.zip from https://github.com/IQSS/dataverse/releases"
  echo "and extract it with 'unzip dvinstall.zip'"
  exit 1
fi

# create solr directory and set permissions
mkdir -p ./data/solr
chmod 777 ./data/solr
