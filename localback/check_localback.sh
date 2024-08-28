#!/bin/bash

slave_status=$(ssh $1 "mysql -e 'show slave status\\G'")

if [[ $(echo "${slave_status}"  | grep 'Slave_IO_Running' | grep 'Yes' ) ]] && [[ $(echo "${slave_status}"  | grep 'Slave_SQL_Running' | grep 'Yes' ) ]]; then
    echo -e '\033[92mreplication ok\033[39m'
else
    echo -e '\033[91mreplication failed\033[39m'
fi

## ssh $1 "mysql demands27 -e 'show slave status\\G'" | grep Slave_IO_Running | grep Yes
#
#echo $slave_status
