#!/bin/bash
DATA_PATH=$(cat DATA_PATH)/aerospike

docker run --restart unless-stopped -d -p 3000:3000 \
-v $DATA_PATH:/opt/aerospike/data \
--name aerospike \
--ulimit nofile=90000:90000 \
brunneis/aerospike-centos:3.9
