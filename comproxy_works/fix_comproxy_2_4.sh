#!/bin/bash

HOSTS='abzakovo oct2 tupak rainbow sunrise mikh elimb izvekova askar6 smelovsk cement most lenina135 greenlog km222 izvekova2 pushkina pravda59 lenina140 vokzalnaya124 km224 km101 agapovka buran km96 loco km178 50let42'

for host in $HOSTS
do
    echo
    echo
    echo $host
    scp ./fixer.sh ./etc_init.d_comproxy $host:~/
    ssh $host './fixer.sh ; rm ./fixer.sh ./etc_init.d_comproxy'
done

