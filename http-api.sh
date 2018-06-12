#!/bin/bash
# Port 8080
docker run --restart unless-stopped -tid \
--name erdd-api \
-v "$(pwd)"/conf/mongo.yaml:/opt/reddit-depression/http-api/mongo.yaml:ro \
-v "$(pwd)"/conf/api.yaml:/opt/reddit-depression/http-api/api.yaml:ro \
--net=host \
catenae/erdd-api

