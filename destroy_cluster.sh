#!/bin/bash

echo "Destroying Swarm cluster..."
docker -H 10.20.30.201:2375 swarm leave --force
docker -H 10.20.30.202:2375 swarm leave --force
docker -H 10.20.30.203:2375 swarm leave --force
