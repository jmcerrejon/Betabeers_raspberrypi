# Author: Jose Cerrejon Gonzalez
#
# Dependencias: sudo apt-get install -y fbi
# 
clear

PHOTODIR=.

fbi -noverbose -a -t 10 -u `find $PHOTODIR -iname "*.jpg"`