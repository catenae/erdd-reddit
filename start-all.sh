#!/bin/bash
export TS=$(date +%s)

function launched {
    echo -e "Launched!\n"
}

function launch {
    echo "Launching $1..."
}

./update-images.sh

# Base frameworks
launch Aerospike
./start-aerospike.sh
launched

launch "Apache Kafka"
./start-kafka.sh
launched

launch MongoDB
./start-mongo.sh
launched

# Store Python objects
sleep 5
launch "Aerospike storer"
./storer.sh
launched

# Interfaces
launch "HTTP API"
./http-api.sh
launched

launch "Web App"
./web-app.sh
launched

# Topologies
launch "Stats topology"
./stats.sh
launched

launch "Depression Classifier"
./classifier.sh
./scale-classifier.sh
launched

launch "Reddit Tracker Topology"
./tracker.sh
./scale-tracker.sh
launched
