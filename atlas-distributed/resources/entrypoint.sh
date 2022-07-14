#!/bin/sh

export MANAGE_LOCAL_HBASE=false
export MANAGE_LOCAL_SOLR=false
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk
until curl -s -f -o /dev/null "http://solr:8983/solr"
do
  echo "waiting for solr to ready"
  sleep 5
done
curl -I "http://solr:8983/solr/admin/collections?action=CREATE&name=fulltext_index&numShards=1&replicationFactor=1"
curl -I "http://solr:8983/solr/admin/collections?action=CREATE&name=edge_index&numShards=1&replicationFactor=1"
curl -I "http://solr:8983/solr/admin/collections?action=CREATE&name=vertex_index&numShards=1&replicationFactor=1"

/opt/atlas/bin/atlas_start.py
sh /tmp/atlas-setup.sh

tail -f /dev/null
