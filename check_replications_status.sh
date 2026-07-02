#!/bin/bash

for host in abzakovo askar6 tupak km222 cement pisareva greenlog lenina135 galiullina most oct2 km180d lenina93d lenina93k rainbow sunrise mikh lenina140 pravda59 izvekova2 km224 agapovka buran loco smelovsk km96 elimb pushkina km178 km101 vokzalnaya124
do
    timeout 20s ./check_localback.sh $host
    if [ $? -eq 124 ]
    then
        printf "%-15s " $host
        echo -e '\033[93mconnection attemps for 20s failed\033[39m'
        /home/nash/ubuntu_init/venv/bin/python3 /home/nash/ubuntu_init/tg_to_test_channel.py $host 'нет соединения'
    fi
    not_confirmed_status=$(ssh $host 'mysql demands27 --skip-column-names -e "select count(*) from loutgo where state=1;"')
    if [ $not_confirmed_status -eq 0 ]
    then
        echo "ok " $host
    else
        echo -e '\033[93merrors\033[39m' $host
    fi
done
