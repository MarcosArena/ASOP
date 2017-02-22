#FALTA CHECKEAR SI EL USUARIO EXITE...

function createRecordatorio() {

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

#Si el titulo tiene espacios, los susituimos por "_"
tituloWithUnder=${titulo/ /_} 

echo "#!/bin/bash" > $ruta_script/"$tituloWithUnder"_"$VALID_ID".sh
echo "#Titulo: $titulo\n \n" >> $ruta_script/"$tituloWithUnder"_"$VALID_ID".sh
echo "#Descripcion: $descripcion \n" >> $ruta_script/"$tituloWithUnder"_"$VALID_ID".sh

echo "export DISPLAY=:0" >> $ruta_script/"$tituloWithUnder"_"$VALID_ID".sh
    
echo "rec=\`zenity 	--info \
	   --title=\"$titulo\" \
	   --text=\"\n Titulo: $titulo \n \n Descripcion: $descripcion\"\
        --width=500 \
        --height=300\`" >> $ruta_script/"$tituloWithUnder"_"$VALID_ID".sh
        
echo "      case $? in
                0)
                    echo Comenzar instalación...;;
                1)
                    echo Has detenido la instalación...;;
                2)
                    echo Ha ocurrido un error inesperado...;;
            esac "  >> $ruta_script/"$tituloWithUnder"_"$VALID_ID".sh
    
    if [ $?=0 ]
        then
        
        now=$(date +'%m/%d/%Y a las %H:%M')
                    
        echo "Se ha creado el script en : $ruta_script/"$tituloWithUnder"_"$VALID_ID".sh"
        #si ha ido bien
        echo "[CREATED] ID del recordatorio: \"$VALID_ID\"  Titulo: \"$titulo\"   Creado por: \"$USER\"     Fecha: \"$now\"" >> $HOME/recordatorios/historial/history.txt
    else
        echo "Error al crear el script. Fíjate en el nombre de usuario $usuario"
    fi
    
    #addToCron $VALID_ID 
}

