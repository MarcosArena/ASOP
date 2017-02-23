#FALTA CHECKEAR SI EL USUARIO EXITE...

function createRecordatorio() {

if [ "$USER" == "root" ]
    then
        #Si ha introducido un usuario como parametro -> ruta del home del usr
        if [ "$usuario" != "root" ]
            then ruta_script="/home/$usuario/recordatorios/recordatorios"
                 ruta_history_usuario="/home/$usuario/recordatorios/historial"
        else
            #Si NO ha introducido un usuario como parametro -> el rec. se crea para root
            ruta_script="/recordatorios/recordatorios"            
        fi
else 
    ruta_script="$HOME/recordatorios/recordatorios"
    ruta_history_usuario="$HOME/recordatorios/historial"
fi

ruta_history_root="/recordatorios/historial"

#Si el titulo tiene espacios, los susituimos por "_"
tituloWithUnder=${titulo/ /_} 
tituloLimpio=${titulo/;/_} 

echo "#!/bin/bash" > $ruta_script/"$tituloWithUnder"_"$VALID_ID".sh
echo "#Titulo: $titulo\n \n" >> $ruta_script/"$tituloWithUnder"_"$VALID_ID".sh
echo "#Descripcion: $descripcion \n" >> $ruta_script/"$tituloWithUnder"_"$VALID_ID".sh

 echo "rec=\`zenity 	--info \
		--title=\"$titulo\" \
		--text=\"\n Titulo: $titulo \n \n Descripcion: $descripcion\"\
        --width=500 \
        --height=300\`" >> $ruta_script/"$tituloWithUnder"_"$VALID_ID".sh
echo " case \$? in
	       0|1)
		      rm -- "$ruta_script/"$tituloWithUnder"_"$VALID_ID".sh";;
	
	       2)
		      echo Ha ocurrido un error inesperado...;;
        esac    " >> $ruta_script/"$tituloWithUnder"_"$VALID_ID".sh
            
if [ $?=0 ]
        then
        
        #le damos permisos al script
        chmod 777 $ruta_script/"$tituloWithUnder"_"$VALID_ID".sh
        
        now=`(date +'%d/%m/%Y %H:%S')`
        
                    
        echo "Se ha creado el script: $ruta_script/"$tituloWithUnder"_"$VALID_ID".sh"
        
        
        echo "[CREATED];$VALID_ID;$tituloLimpio;$USER;$usuario;$now" >> $ruta_history_root/history.txt
        
        echo "[CREATED] ID del recordatorio: \"$VALID_ID\"      Titulo: \"$titulo\"     Creado para: \"$usuario\"       Fecha: \"$now\"" >> $ruta_history_usuario/history.txt
        
    else
        echo "Error al crear el script. Fíjate en el nombre de usuario $usuario"
        exit
    fi
    
}

