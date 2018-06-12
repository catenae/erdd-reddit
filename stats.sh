#!/bin/bash
docker run -d --restart unless-stopped --net=host --name stats_$TS \
catenae/stats-link stats \
-i processed_texts,processed_users \
-b 127.0.0.1:9092
