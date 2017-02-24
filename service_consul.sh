#!/bin/bash

if [ $? -eq 0 ];then
  curl -X PUT -d '{"Datacenter": "dc1", "Node": "mongo","Address": "172.16.0.21","Service": {"Service": "mongo", "Port": 27017}}' http://127.0.0.1:8500/v1/catalog/register
  curl -X PUT -d '{"Datacenter": "dc1", "Node": "mysql","Address": "172.16.0.21","Service": {"Service": "mysql", "Port": 3306}}' http://127.0.0.1:8500/v1/catalog/register
else
  echo "make sure service has running"
fi
