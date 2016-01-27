#!/bin/bash
docker-machine stop seed client
docker-machine rm seed client
docker-machine create -d virtualbox seed
docker-machine create -d virtualbox client
