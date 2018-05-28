#!/bin/bash

DATA_PATH=/media/data/kafka

docker run --restart unless-stopped -d --net=host  \
--cpuset-cpus="0-15" \
-v $DATA_PATH:/opt/kafka/default/logs \
--ulimit nofile=90000:90000 \
--name kafka \
catenae/kafka

# docker run -d --name kafka-manager -p 9000:9000 -e ZK_HOSTS="127.0.0.1:2181" -e APPLICATION_SECRET=gradox sheepkiller/kafka-manager # --link kafka:kafka
