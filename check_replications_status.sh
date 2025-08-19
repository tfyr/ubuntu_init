#!/bin/bash

for host in askar askar6 tupak km222 cement pisareva greenlog lenina135 galiullina most oct2 km180d lenina93d lenina93k rainbow sunrise-new
do
    timeout 20s ./check_localback.sh $host
    if [ $? -eq 124 ]
    then
        printf "%-15s " $host
        echo -e '\033[93mconnection attemps for 10s failed\033[39m'
        ~/.virtualenvs/check_replication/bin/python3 tg_to_test_channel.py $host 'нет соединения'
    fi
done
