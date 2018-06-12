#!/bin/bash

# Base frameworks
docker rm -f aerospike kafka mongo

# Interfaces
docker rm -f erdd-api catenae

# Topologies
docker rm -f $(docker ps -a | grep catenae | awk '{print $1}')

# Cleaning
docker volume rm $(docker volume ls -q -f dangling=true)
sudo rm -rf $(cat DATA_PATH)
