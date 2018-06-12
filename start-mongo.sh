#!/bin/bash
DATA_PATH=$(cat DATA_PATH)/mongo

docker run --restart unless-stopped -d \
-p 27017:27017 \
-v $DATA_PATH:/data/db \
--name mongo \
--ulimit nofile=90000:90000 \
mongo:3.6
