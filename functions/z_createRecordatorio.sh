function z_createRecordatorio() {
#str_fecha=$( date -d $fecha +'%d_%m_%Y')	

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

echo $ruta_script

    echo "#!/bin/bash" > $ruta_script/"$VALID_ID".sh
    echo "#Titulo: $titulo " > $ruta_script/"$VALID_ID".sh
    echo "#Descripcion: $descripcion \n" >> $ruta_script/"$VALID_ID".sh
    
    echo "export DISPLAY=:0" >> $ruta_script/"$tituloWithUnder"_"$VALID_ID".sh
    
    
    echo "rec=\`zenity 	--info \
		--title=\"$titulo\" \
		--text=\"\n Titulo: $titulo \n \n Descripcion: $descripcion\"\
        --width=500 \
        --height=300\`" >> $ruta_script/"$VALID_ID".sh
    echo " case $? in
	0)
		echo Comenzar instalación...;;
	1)
		echo Has detenido la instalación...;;
	2)
		echo Ha ocurrido un error inesperado...;;
esac    " >> $ruta_script/"$VALID_ID".sh
    
    if [ $?=0 ]
        then 
        now=$(date +'%m/%d/%Y a las %H:%M')
        echo "Se ha creado el script: $ruta_script/"$VALID_ID".sh"
        echo echo "[ CREATED ] Fecha: \"$now\"     ID del recordatorio: \"$VALID_ID\"     Titulo: \"$titulo\"     Creado por: \"$USER\"" >> $HOME/recordatorios/historial/history.txt
    else
        echo "Error al crear el script."
    fi
    
}