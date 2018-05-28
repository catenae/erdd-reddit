#!/bin/bash

DATA_PATH=/media/data/aerospike

docker run --restart unless-stopped -d -p 3000:3000 \
--cpuset-cpus="0-15" \
-v $DATA_PATH:/opt/aerospike/data \
--name aerospike \
--ulimit nofile=90000:90000 \
brunneis/aerospike-centos:3.9
sleep 10 && docker run -ti --net=host catenae/erdd-aerospike-storer
