#!/bin/bash
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

GPIO_RADIO(){
    sudo $HOME/pifm $HOME/halt.wav 95 &
    dialog --infobox "Estás escuchando..." 3 23; sleep 9
    dialog --infobox "Halt and Catch Fire" 3 23; sleep 21
}

RPLAY(){
    dialog  --title     "[ RPlay ]" \
        --backtitle "${BTITLE}" \
        --yes-label "Encender" \
        --no-label  "Apagar" \
        --yesno     "¿Qué deseas hacer?" 7 60

    response=$?
    case $response in
       0) clear ; sudo update-rc.d -f rplay enable ; sudo /etc/init.d/rplay start ; read -p "Activado. Pulse una tecla para continuar...";;
       1) clear ; sudo /etc/init.d/rplay stop ; sudo update-rc.d -f rplay disable; read -p "Desactivado. Pulse una tecla para continuar...";;
       255) echo "[ESC] key pressed.";;
    esac
}

OWNCLOUD(){
    dialog  --title     "[ ownCloud ]" \
        --backtitle "${BTITLE}" \
        --yes-label "Encender" \
        --no-label  "Apagar" \
        --yesno     "¿Qué deseas hacer?" 7 60

    response=$?
    case $response in
       0) clear ; sudo update-rc.d -f nginx enable ; sudo /etc/init.d/nginx start ; read -p "Activado. Pulse una tecla para continuar...";;
       1) clear ; sudo /etc/init.d/nginx stop ; sudo update-rc.d -f nginx disable; read -p "Desactivado. Pulse una tecla para continuar...";;
       255) echo "[ESC] key pressed.";;
    esac
}

CAMERA(){
    dialog  --title     "[ Cámara ]" \
        --backtitle "${BTITLE}" \
        --yes-label "Encender" \
        --no-label  "Apagar" \
        --yesno     "¿Qué deseas hacer?" 7 60

    response=$?
    case $response in
       0) clear ; sudo update-rc.d -f nginx enable ; sudo /etc/init.d/nginx start ; read -p "Activado. Pulse una tecla para continuar...";;
       1) clear ; sudo /etc/init.d/nginx stop ; sudo update-rc.d -f nginx disable; read -p "Desactivado. Pulse una tecla para continuar...";;
       255) echo "[ESC] key pressed.";;
    esac
}

EMULATORS(){
    echo "lo q sea"
}

# Main menu

while true
do
    dialog --clear --backtitle "${BTITLE}" \
    --title "[ ¿Para qué quiero yo una Raspberry PI? ]" --menu "" 13 70 13 \
    Desktop "Escritorio ligero LXDE" \
    RPlay "AirPlay mirroring" \
    GPIO "General Purpose Input Output" \
    ownCloud "Tu propio espacio en la nube" \
    Camara "* Prueba de cámara para videovigilancia" \
    Emuladores "* Emula casi a la perfección cualquier sistema retro" \
    Sorteo "Sorteo Kit Raspberry Pi @raspipc" \
    Exit "Salir a la Shell" 2>"${INPUT}"

    menuitem=$(<"${INPUT}")

    case $menuitem in
        Desktop) startx;;
        RPlay) RPLAY;;
        GPIO) GPIO_RADIO;;
        ownCloud) OWNCLOUD;;
        Camara) CAMERA;;
        Emuladores) EMULATORS;;
        Sorteo) RandomNum; echo -e "\nVisita misapuntesde.com :)"; break;;
        Exit) echo "Visita misapuntesde.com :)"; break;;
    esac

done