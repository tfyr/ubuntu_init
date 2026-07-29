#!/bin/bash

# Определяем цвета
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color (сброс)

# Символы
CHECKMARK="✓"
CROSS="✗"
WARNING="⚠"

TARGET_FILE="/etc/init.d/comproxy"

MD5=$(md5sum "$TARGET_FILE" | cut -d' ' -f1)

if [ "$MD5" = "b43d2f1c6ea122a883ac1c3e4cfa6bab" ]; then
    echo -e "${YELLOW}${CHECKMARK} уже сделано${NC}"
elif [ "$MD5" = "d03696c22d496c88909b5d2183f01f0a" ]; then
    echo -e "${GREEN}${CHECKMARK} надо сделать. начинаю${NC}"
    sudo cp ./etc_init.d_comproxy /etc/init.d/comproxy
else
    echo -e "${RED}${CROSS} не подходит, возможно не та версия${NC}"
fi
