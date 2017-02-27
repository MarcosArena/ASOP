#AUTOR -> MARCOS ARENA

#Falta checkear si el usuario existe

function createRecordatorio() {

#Si el titulo tiene espacios, los susituimos por "_"
tituloWithUnder=${titulo// /-} 
tituloLimpio=${titulo//;/-}

if [ "$USER" == "root" ]
    then
        #Si ha introducido un usuario como parametro -> ruta del home del usr
        if [ "$usuario" != "root" ]
            then ruta_script="/home/$usuario/recordatorios/scripts"
                 ruta_history_usuario="/home/$usuario/recordatorios/historial"
        else
            #Si NO ha introducido un usuario como parametro -> el rec. se crea para root
            ruta_script="/recordatorios/scripts"            
        fi
else 
    ruta_script="$HOME/recordatorios/scripts"
    ruta_history_usuario="$HOME/recordatorios/historial"
fi

ruta_history_root="/recordatorios/historial"

#Asignamos la ruta completa del script a $script
script=$ruta_script/"$tituloWithUnder"_"$VALID_ID".sh

# -> INICIO >> SCRIPT <-
echo "#!/bin/bash" > $script
echo "export DISPLAY=:0" >> $script
echo "#Titulo: $titulo\n \n" >> $script
echo "#Descripcion: $descripcion \n" >> $script

echo "rec=\`zenity 	--info \
		--title=\"$titulo\" \
		--text=\"\n Titulo: $titulo \n \n Descripcion: $descripcion\"\
        --width=500 \
        --height=300\`" >> $script
echo " case \$? in

	       0) 
              rm -- "$script";;
           1)
		      rm -- "$script";;
	
	       2)
		      echo Ha ocurrido un error inesperado...;;
        esac    " >> $script

#-> FINAL SCRIPT <-

if [ $?=0 ]
        then
        
        #le damos permisos al script
        chmod 777 $script
        #Calculamos la fecha actual
        fecha=`(date +"%d-%m-%Y")`
	hora=`(date +"%H:%M")`
        clear
                    
        echo "Se ha creado el script: $script"
        
        # HISTORIAL
        echo "[CREATED];$VALID_ID;$tituloLimpio;$USER;$usuario;$fecha;$hora" >> $ruta_history_root/history.txt        
        echo "[CREATED] Titulo: \"$tituloLimpio\"   Fecha: \"$fecha a las $hora\"   ID del recordatorio: \"$VALID_ID\"   Creado por: \"$USER\" ">> $ruta_history_usuario/history.txt
        
    else
        echo "Error al crear el script."
        exit
    fi    
}

