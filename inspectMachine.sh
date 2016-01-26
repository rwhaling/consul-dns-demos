#!/bin/bash
MACHINE_NAME=${1:-$(docker-machine active)}
MACHINE_IP=$(docker-machine ip ${MACHINE_NAME})
BRIDGE_INTERFACE=$(docker-machine ssh $MACHINE_NAME ifconfig docker0)
BRIDGE_IP=$(echo "$BRIDGE_INTERFACE" | grep 'inet addr:' | cut -d: -f2  | awk '{ print $1}')
echo export MACHINE_IP="$MACHINE_IP"
echo export BRIDGE_IP="$BRIDGE_IP"
