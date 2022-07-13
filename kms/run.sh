#!/bin/bash

$HADOOP_HOME/bin/hadoop  --daemon start kms

while true
do
        echo "running run.sh"
        sleep 1000
done

