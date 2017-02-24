#!/bin/bash

sleep 2s
if [ $? == 0 ]; then
  curl -X PUT http://localhost:8500/v1/kv/config/application/data --data-binary @application-prod.yml
else
  echo "make sure consul service has running"
fi
