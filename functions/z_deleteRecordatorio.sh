#!/bin/bash

#AUTOR -> MARCOS ARENA

if [ "$USER" == "root" ]
    then
        #Si ha introducido un usuario como parametro -> ruta del home del usr
        if [ "$usuario" != "root" ]
            then ruta_script="/home/$usuario/recordatorios"
        else
            #Si ha introducido un usuario como parametro -> el rec. se crea para root
            ruta_script="/root/recordatorios"
        fi
else 
    ruta_script="$HOME/recordatorios"
fi

archivo=`zenity --file-selection --filename=$ruta_script/ --title="Selecciona un archivo"`

case $? in 
	0) 
		echo $archivo;;	
	1) 	
		echo "No ha seleccionado ningún archivo.";;
	2)
		echo "Ha ocurrido un error inesperado.";;
esac
