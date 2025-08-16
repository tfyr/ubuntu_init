#!/bin/bash

for f in /dev/ttyA* ;do
    udevadm info -q all -a $f | grep 'ATTRS{idProduct}=="903b"'   # Android terminal
    #udevadm info -q all -a $f | grep 'ATTRS{manufacturer}=="NXP"'  # Shtrikh 
    #udevadm info -q all -a $f | grep 'ATTRS{product}=="STM32 Virtual ComPort  in FS Mode"'  # VikiPrint
    if [ $? -eq 0 ]; then
        f_escaped=$(echo $f | sed 's/\//\\\//g')
        sed -i -e  "s/PORT=\/dev\/ttyACM[0-9]\+/PORT=$f_escaped/g" /home/pos/ArcusIngenicoDriver/Linux64/libarccom21036/cashreg.ini
    fi
done
