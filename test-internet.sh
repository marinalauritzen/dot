#!/bin/bash

while [ 1 ]
do
  echo "checking internet connection..."
  curl google.com -s > /dev/null
  if [ $? -eq 0 ]
  then
    echo "connected"
    say "connected"
    break
  fi
  echo "$(date) retrying..."
  sleep 15
done
