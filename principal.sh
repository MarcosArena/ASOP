#!/bin/bash

. ./functions/checkDate.sh
. ./functions/checkTimeFormat.sh
. ./functions/getTimeAndDate.sh
. ./functions/generateID.sh
. ./functions/checkExists.sh
. ./functions/getFileName.sh
. ./functions/getRecordatorio.sh
. ./functions/createRecordatorio.sh


clear

#VALID_ID = Al output de la funcion getFileName
VALID_ID=$(getFilename)


#Comprobamos si el usuario que ha ejecutado la orden es root
if [ $USER == "root" ]
    then
    usuario=$6    
else
    if [ $6 ] 
        then echo "Debes ser root para seleccionar un usuario"
        exit
    else
        usuario=       
    fi
fi



checkDate $2 $3

getRecordatorio  "$timeAndDate" "$4" "$5" $usuario

echo $nombre $descripcion

#bash $HOME/recordatorios/"$VALID_ID".sh

echo $recordatorio

#echo $timeAndDate





