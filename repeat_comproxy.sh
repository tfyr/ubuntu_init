#!/bin/bash

x=1
while [ $x -lt 500 ]
do
  echo "Значение счетчика: $x"
  sudo ./comproxy_check_ports.sh
  sudo systemctl restart comproxy
  sleep 120s
  x=$(( $x + 1 ))
done
