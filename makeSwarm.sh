#!/bin/bash

docker-machine create -d virtualbox swarm-keystore
export MACHINE_IP=$(docker-machine ip swarm-keystore)
eval $(docker-machine env swarm-keystore)
echo "swarm keystore at $MACHINE_IP"
SWARM_KEYSTORE="$MACHINE_IP"
echo "cleaning up old containers"
./cleanup.sh

echo "starting consul"
docker-compose up -d consul-seed

docker-machine create -d virtualbox \
  --swarm --swarm-master \
  --swarm-discovery="consul://$SWARM_KEYSTORE:8500" \
  --engine-opt="cluster-store=consul://$SWARM_KEYSTORE:8500" \
  --engine-opt="cluster-advertise=eth1:2376" \
  swarm-master
SWARM_MASTER=$(docker-machine ip swarm-master)
echo "swarm master at $SWARM_MASTER"

docker-machine create -d virtualbox \
  --swarm \
  --swarm-discovery="consul://$SWARM_KEYSTORE:8500" \
  --engine-opt="cluster-store=consul://$SWARM_KEYSTORE:8500" \
  --engine-opt="cluster-advertise=eth1:2376" \
  swarm-worker-1
SWARM_WORKER=$(docker-machine ip swarm-worker-1)
echo "swarm worker at $SWARM_WORKER"

eval $(docker-machine env --swarm swarm-master)
docker network create --driver overlay swarm-net
echo "created network swarm"
