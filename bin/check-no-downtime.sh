#!/bin/bash

echo -n "Waiting for downtime... "
while curl -f -s http://127.0.0.1/ -o /dev/null
do
  sleep 0.1
done
echo "Downtime !"
