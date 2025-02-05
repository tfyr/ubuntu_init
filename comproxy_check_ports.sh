#!/bin/bash

for f in /dev/ttyA* ;do
    #udevadm info -q all -a $f | grep 'ATTRS{idProduct}=="903b"'   # Android terminal
    #udevadm info -q all -a $f | grep 'ATTRS{manufacturer}=="NXP"'  # Shtrikh 
    udevadm info -q all -a $f | grep 'ATTRS{product}=="STM32 Virtual ComPort  in FS Mode"'   # Viki
    if [ $? -eq 0 ]; then
        f_escaped=$(echo $f | sed 's/\//\\\//g')
        sudo sed -i -e  "s/physical_port=\/dev\/ttyACM[0-9]/physical_port=$f_escaped/g" /opt/comproxy/ComProxy.ini
    fi
done
