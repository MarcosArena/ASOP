#!/bin/bash
. ./functions/deleteRecordatorio.sh
#AUTOR -> MARCOS ARENA
function z_delete(){



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

arrID=(${archivo//_/ })
ID=${arrID[1]}

#Quitamos el .sh
ID=`expr substr $ID 1 8`



case $? in 
	0) 
		delete $ID;;
	1) 	
		echo "No ha seleccionado ningún archivo.";;
	2)
		echo "Ha ocurrido un error inesperado.";;
esac

}
