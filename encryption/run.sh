#!/bin/bash

hadoop key create mykey
hadoop dfs  -mkdir  /hbase
hdfs crypto -createZone -keyName mykey -path /hbase

python -m SimpleHTTPServer 17000
