#!/bin/sh

export MANAGE_LOCAL_HBASE=true
export MANAGE_LOCAL_SOLR=true
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk

/opt/atlas/hbase/bin/start-hbase.sh
/opt/atlas/solr/bin/solr start -c -z 127.0.0.1:2181 -p 8983 -force
while netstat -lnt | awk '$4 ~ /:8983$/ {exit 1}'; do
    echo "waiting for solr to be ready"
    sleep 1;
done

/opt/atlas/solr/bin/solr create -c fulltext_index -force -d /opt/atlas/conf/solr/
/opt/atlas/solr/bin/solr create -c edge_index -force -d /opt/atlas/conf/solr/
/opt/atlas/solr/bin/solr create -c vertex_index  -force -d /opt/atlas/conf/solr/

/opt/atlas/bin/atlas_start.py
sh /tmp/atlas-setup.sh

tail -f /dev/null
