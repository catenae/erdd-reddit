#!/bin/bash
DATA_PATH=/media/data/kafka

docker run --restart unless-stopped -d --net=host  \
-v $DATA_PATH:/opt/kafka/default/logs \
--ulimit nofile=90000:90000 \
--name kafka \
catenae/kafka
