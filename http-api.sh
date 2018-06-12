#!/bin/bash
docker run --restart unless-stopped -tid \
--name erdd-api \
-v "$(pwd)"/conf/mongo.yaml:/opt/reddit-depression/http-api/mongo.yaml:ro \
-v "$(pwd)"/conf/api.yaml:/opt/reddit-depression/http-api/api.yaml:ro \
-p 8080:8080 \
--net=host \
catenae/erdd-api

