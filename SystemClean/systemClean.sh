#!/bin/bash

# Colours
RED="\e[0;31m\033[1m"
YELLOW="\e[0;33m\033[1m"
ORANGE="\033[0;33m"
BLUE="\e[0;34m\033[1m"
GREEN="\e[0;32m\033[1m"
PURPLE="\e[0;35m\033[1m"
TURQUOISE="\e[0;36m\033[1m"
GRAY="\e[0;37m\033[1m"
NC="\033[0m\e[0m"

# Banner
banner="
                        ${RED}+-------------------------------------+
                        |${NC}            ${YELLOW}System Clean${NC}             ${RED}|
                        |                                     |
                        |${NC} ${YELLOW}Author:${NC} Altf4-sh                    ${RED}|  
                        |${NC} ${YELLOW}GitHub:${NC} https://github.com/Altf4-sh ${RED}|
                        |${NC} ${YELLOW}Version:${NC} 1.0                        ${RED}|
                        +-------------------------------------+${NC}
"

echo -e "$banner"

echo -e "\n${YELLOW}[+]${NC} ${GREY}Limpiando archivos temporales...${NC}"
sleep 0.5
sudo rm -rf /temp/*
sleep 0.5

echo -e "\n${YELLOW}[+]${NC} ${GREY}Limpiando caché paquetes descargados...${NC}"
sleep 0.5
sudo apt-get clean
sleep 0.5

echo -e "\n${YELLOW}[+]${NC} ${GREY}Limpiando caché usuario actual...${NC}"
sleep 0.5
sudo rm -rf ~/.cache/*

echo -e "\n${YELLOW}[+]${NC} ${GREY}Limpiando paquetes obsoletos...${NC}"
sleep 0.5
sudo apt-get autoclean
sleep 0.5

echo -e "\n${YELLOW}[+]${NC} ${GREY}Limpiando logs de más de 7 días...${NC}"
sleep 0.5
sudo journalctl --vacuum-time=7d
sleep 0.5

echo -e "\n${YELLOW}[+]${NC} ${GREY}Limpiando papelera de reciclaje...${NC}"
sleep 0.5
rm -rf ~/.local/share/Trash/*
sleep 0.5

echo -e "\n${PURPLE}[+]${NC} ${GREEN}Limpieza completada!${NC}"