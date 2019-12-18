#!/bin/bash

while true
do
  echo -n "[$(date +'%T')] Waiting for uptime... "
  while ! curl -f -s http://127.0.0.1/ -o /dev/null
  do
    sleep 0.1
  done
  echo "Uptime !"

  echo -n "[$(date +'%T')] Waiting for Downtime... "
  while curl -f -s http://127.0.0.1/ -o /dev/null
  do
    sleep 0.1
  done
  echo "Downtime !"
done
