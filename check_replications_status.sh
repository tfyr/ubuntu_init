#!/bin/bash

for host in askar askar6 tupak km222 cement pisareva greenlog lenina135 galiullina most oct2 km180d lenina93d lenina93k elimb rainbow sunrise-new
do
    timeout 20s ./check_localback.sh $host
    if [ $? -eq 124 ]
    then
        printf "%-15s " $host
        echo -e '\033[93mconnection attemps for 10s failed\033[39m'
        /home/nash/ubuntu_init/venv/bin/python3 /home/nash/ubuntu_init/tg_to_test_channel.py $host 'нет соединения'
    fi
done
