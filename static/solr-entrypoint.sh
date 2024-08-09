#! /bin/bash
set -e
cp -r /opt/solr/server/solr/configsets/_default /tmp/template
cp /tmp/dvinstall/schema.xml /tmp/dvinstall/solrconfig.xml /tmp/template/conf
solr-precreate collection1 /tmp/template
