#!/bin/bash
. ./functions/z_getDate.sh
. ./functions/z_checkTimeFormat.sh
. ./functions/z_getTimeAndDate.sh
. ./functions/generateID.sh
. ./functions/checkExists.sh
. ./functions/getFileName.sh
. ./functions/z_getRecordatorio.sh
. ./functions/z_createRecordatorio.sh
. ./functions/z_getTime.sh


VALID_ID=$(getFilename)

if [ $USER==root ]
then 
    zenity --question --title="¿Usuario?" --text="¿Quieres crear un recordatorio para otro usuario? \n\n Cancelar para añadir solo a root." 
    
    if [ $? = 0 ]
        then usuario=`zenity --entry --title="Usuario" --text="Añade el nombre del usuario" \
			--entry-text="Usuario..."`
            if [ $usuario ]
                then usuario = $usuario                
                z_getDate                
            else 
                exit
            fi
    else 
        usuario="root"
        z_getDate
    fi
else 
    usuario=$usuario
    z_getDate
fi

echo $usuario    
echo $recordatorio 
echo $finalstring
bash $ruta_script/"$VALID_ID".sh
#getTimeAndDate 
#getRecordatorio