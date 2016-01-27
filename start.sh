#!/bin/bash
export SEED_NAME="seed"
export CLIENT_NAME="client"

export MACHINE_IP=$(docker-machine ip ${SEED_NAME})
export SEED_IP="$MACHINE_IP"

echo "setting up seed node"
eval $(docker-machine env $SEED_NAME)
echo "machine $SEED_NAME:$MACHINE_IP"
echo SEED_IP="$MACHINE_IP"

echo "cleaning up old containers"
./cleanup.sh

echo "starting consul"
docker-compose up -d consul-seed

echo "starting registrator"
docker-compose up -d registrator

echo "starting nginx"
docker run -d -P --dns $MACHINE_IP nginx

echo "starting redis"
docker run -d -P --dns $MACHINE_IP redis

echo "setting up client node"
export MACHINE_IP=$(docker-machine ip ${CLIENT_NAME})
eval $(docker-machine env $CLIENT_NAME)
echo "machine $CLIENT_NAME:$MACHINE_IP"
echo CLIENT_IP="MACHINE_IP"

echo "cleaning up old containers"
./cleanup.sh

echo "starting consul"
docker-compose up -d consul-client

echo "starting registrator"
docker-compose up -d registrator

echo "staring redis"
docker run -d -P --dns $MACHINE_IP redis

echo "scanning for services with dig"
docker-compose up scanner

echo "building dns scanner app"
pushd containers/scanner
spring jar scanner.jar *.groovy
docker build .
popd
echo "starting dns scanner app"
docker-compose up -d scanner-app
echo "done"