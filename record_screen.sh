#!/bin/bash

#ffmpeg -y -f x11grab -framerate 20 -r 20 -s 1280x1024 -i :0.0 -t 595 ~/video/$(date +"%H-%M").mpg
ffmpeg -y -f x11grab -framerate 20 -r 20 -s 1920x1080 -i :0.0 -vf scale=960:-2,setsar=1:1 -t 595 ~/video/$(date +"%H-%M").mpg
