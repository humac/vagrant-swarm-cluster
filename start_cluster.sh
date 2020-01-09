#!/bin/bash

echo "Starting manager node1..."
docker -H tcp://10.0.7.10:2375 swarm init --advertise-addr 10.0.7.10

echo "Retrieve manager token..."
TOKEN=$(docker -H tcp://10.0.7.10:2375 swarm join-token -q worker)

echo "Starting worker node2..."
docker -H tcp://10.0.7.11:2375 swarm join --token "${TOKEN}" 10.0.7.10:2377

echo "Starting worker node3..."
docker -H tcp://10.0.7.12:2375 swarm join --token "${TOKEN}" 10.0.7.10:2377

docker -H tcp://10.0.7.10:2375 info
