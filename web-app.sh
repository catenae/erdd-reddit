#!/bin/bash
# Port 80
docker run --restart unless-stopped -tid --net=host \
--name catenae \
catenae/web-app
