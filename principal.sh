#!/bin/bash

. ./functions/checkDate.sh
. ./functions/checkTimeFormat.sh
. ./functions/generateID.sh
. ./functions/checkExists.sh
. ./functions/getFileName.sh
. ./functions/getRecordatorio.sh
. ./functions/z_getRecordatorio.sh
. ./functions/createRecordatorio.sh
. ./functions/addToCron.sh

clear

#VALID_ID = Al output de la funcion getFileName
VALID_ID=$(getFilename)


#Comprobamos si el usuario que ha ejecutado la orden es root
if [ "$USER" == "root" ]
    then
        if [ $6 ]
            then usuario=$6
        else
            usuario="root"
        fi
else 
    if [ $6 ]
            then echo "Debes ser root para añadir un usuario."
            exit
        else
            usuario=""
        fi
fi

checkDate $2 $3

getRecordatorio  "$timeAndDate" "$4" "$5" $usuario

#echo $titulo $descripcion

#bash $HOME/recordatorios/"$VALID_ID".sh

if [ "$usuario" != "" ]
    then 
    finalString="$timeAndDate $usuario bash $ruta_script/"$tituloWithUnder"_"$VALID_ID".sh"
else
    finalString="$timeAndDate bash $ruta_script/"$tituloWithUnder"_"$VALID_ID".sh"
fi

addToCron




#addToCron "$finalString"


