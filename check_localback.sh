#!/bin/bash

slave_status=$(ssh $1 "mysql -e 'show replica status\\G'" 2>&1)

printf "%-15s " $1
if [[ $(echo "${slave_status}"  | grep '_IO_Running' | grep 'Yes' ) ]] && [[ $(echo "${slave_status}"  | grep '_SQL_Running' | grep 'Yes' ) ]]; then
    echo -e '\033[92m[ok]\033[39m'
elif [[ $(echo "${slave_status}"  | grep 'No route to host' ) ]]; then
    echo -e '\033[91m[failed no route]\033[39m'
    /home/nash/ubuntu_init/venv/bin/python3 /home/nash/ubuntu_init/tg_to_test_channel.py $1 'No route to host'
else
    echo -e '\033[91m[failed]\033[39m'
    /home/nash/ubuntu_init/venv/bin/python3 /home/nash/ubuntu_init/tg_to_test_channel.py $1 'Нарушена репликация'
fi

