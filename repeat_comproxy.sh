#!/bin/bash

x=1
while [ $x -lt 100 ]
do
  echo "Значение счетчика: $x"
  sudo systemctl restart comproxy
  sleep 120s
  x=$(( $x + 1 ))
done
