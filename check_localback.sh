#!/bin/bash

slave_status=$(ssh $1 "mysql -e 'show slave status\\G'")

printf "%-15s " $1
if [[ $(echo "${slave_status}"  | grep 'Slave_IO_Running' | grep 'Yes' ) ]] && [[ $(echo "${slave_status}"  | grep 'Slave_SQL_Running' | grep 'Yes' ) ]]; then
    echo -e '\033[92m[ok]\033[39m'
else
    echo -e '\033[91m[failed]\033[39m'
    /home/nash/ubuntu_init/venv/bin/python3 /home/nash/ubuntu_init/tg_to_test_channel.py $1 'Нарушена репликация'
fi

## ssh $1 "mysql demands27 -e 'show slave status\\G'" | grep Slave_IO_Running | grep Yes
#
#echo $slave_status
