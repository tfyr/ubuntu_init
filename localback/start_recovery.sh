#!/bin/bash

if [ -L ~/kirsa/kirsa.sock.lock ]; then
  rm ~/kirsa/kirsa.sock.lock
fi
if [ -S ~/kirsa/kirsa.sock ]; then
  rm ~/kirsa/kirsa.sock
fi
/home/pos/kirsa/env/bin/daphne -u /home/pos/kirsa/kirsa.sock kirsa.asgi:application

