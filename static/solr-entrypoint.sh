#! /bin/bash
set -e
cp -r /opt/solr/server/solr/configsets/_default /tmp/template
cp /mnt/dvinstall/schema.xml /mnt/dvinstall/solrconfig.xml /tmp/template/conf
solr-precreate collection1 /tmp/template
