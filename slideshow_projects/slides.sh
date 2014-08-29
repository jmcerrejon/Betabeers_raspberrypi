# Author: Jose Cerrejon Gonzalez
#
# Dependencias: sudo apt-get install -y fbi
# 
clear

PHOTODIR=$HOME/Betabeers_raspberrypi/slideshow_projects/

fbi -noverbose -a -t 10 -u `find $PHOTODIR -iname "*.jpg"`