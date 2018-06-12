#!/bin/bash
docker run --restart unless-stopped -tid --net=host \
--name catenae \
-p 80:80 \
catenae/web-app
