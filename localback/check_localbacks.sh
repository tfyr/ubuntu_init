#!/bin/bash

for host in askar tupak48 cement pisareva rainbow sunrise-new
do
    echo $host
    timeout 10s ./check_localback.sh $host
    if [ $? -eq 124 ]
    then
        echo -e '\033[93mconnection attemps for 10s failed\033[39m'
    fi
    echo ''
done
