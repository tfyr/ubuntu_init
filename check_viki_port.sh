#!/bin/bash

for f in /dev/ttyA* ;do
    #udevadm info -q all -a $f | grep 'ATTRS{idProduct}=="903b"'   # Android terminal
    #udevadm info -q all -a $f | grep 'ATTRS{manufacturer}=="NXP"'  # Shtrikh 
    udevadm info -q all -a $f | grep 'ATTRS{product}=="STM32 Virtual ComPort  in FS Mode"'  # VikiPrint
    if [ $? -eq 0 ]; then
        f_escaped=$(echo $f | sed 's/\//\\\//g')
        sed -i -e  "s/physical_port=\/dev\/ttyACM[0-9]\+/physical_port=$f_escaped/g" /opt/comproxy/ComProxy.ini
        systemctl status comproxy | grep 'active (running)'
        if [ $? -eq 0 ]; then
            echo $(date) >> /home/pos/restart_comproxy.txt
            systemctl restart comproxy
        fi
        break
    fi
done
