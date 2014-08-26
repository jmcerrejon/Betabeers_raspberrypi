#!/bin/bash -x
#
# Author: Jose Cerrejon Gonzalez
#
# Dependencias: sudo apt-get install -y toilet dialog 
#
clear

# Capturamos las respuestas en el fichero siguiente

INPUT=/tmp/mnu.sh.$$
BTITLE="BetaBeers Huelva | Fecha: $(date '+%d/%m/%y') | José Manuel Cerrejón González | IP: $(hostname -I)"
# Borramos el fichero anterior cuando salgamos

trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM

RandomNum(){
    clear
    dialog --inputbox "Introduce número máximo:" 8 40 2>"${INPUT}"
    dialog --infobox "Y el ganador es..." 3 33; sleep 5
    dialog --infobox "Ya viene, ya viene... ;)" 3 33; sleep 5
    MAX_NUMBER=$(<"${INPUT}")
    RANDOM_NUM=$[($RANDOM%${MAX_NUMBER})+1]
    clear && toilet -f mono12 -F metal $RANDOM_NUM
    echo -e "Ganador Kit Raspberry Pi: ${RANDOM_NUM}\n"'Código utilizado: $[($RANDOM%${MAX_NUMBER})+1]' > ganador
    read -p "E N H O R A B U E N A - N Ú M E R O: ${RANDOM_NUM}"
}

RPLAY(){
    dialog  --title     "RPlay" \
        --backtitle "${BTITLE}" \
        --yes-label "Encender" \
        --no-label  "Apagar" \
        --yesno     "¿Qué deseas hacer?" 7 60

    response=$?
    case $response in
       0) sudo update-rc.d -f rplay enable ; sudo /etc/init.d/rplay start;;
       1) sudo /etc/init.d/rplay stop ; sudo update-rc.d -f rplay disable;;
       255) echo "[ESC] key pressed.";;
    esac
}

# Main menu

while true
do
    dialog --clear --backtitle "${BTITLE}" \
    --title "[ ¿Para qué quiero yo una Raspberry PI? ]" --menu "" 15 60 5 \
    Desktop "Escritorio ligero LXDE" \
    RPlay "AirPlay mirroring" \
    Sorteo "Sorteo Kit Raspberry Pi @raspipc" \
    Exit "Salir a la Shell" 2>"${INPUT}"

    menuitem=$(<"${INPUT}")

    case $menuitem in
        Desktop) startx;;
        RPlay) RPLAY;;
        Sorteo) RandomNum; echo "Visita misapuntesde.com :)"; break;;
        Exit) echo "Visita misapuntesde.com :)"; break;;
    esac

done