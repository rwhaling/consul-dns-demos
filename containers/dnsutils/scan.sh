#!/bin/bash
sleep 3
echo "scanning for nginx"
dig nginx-80.service.consul. SRV | egrep "^[^;].*SRV"
dig nginx-443.service.consul. SRV | egrep "^[^;].*SRV"
echo "scanning for redis"
dig redis.service.consul. SRV | egrep "^[^;].*SRV"
