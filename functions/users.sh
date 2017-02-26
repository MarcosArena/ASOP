#!/bin/bash
#Oscar Cobo Gomez
. ./functions/sintaxis.sh
. ./functions/addToCron.sh
. ./functions/users.sh
. ./functions/checkDate.sh
. ./functions/checkTimeFormat.sh
. ./functions/generateID.sh
. ./functions/checkExists.sh
. ./functions/getFileName.sh
. ./functions/getRecordatorio.sh
. ./functions/createRecordatorio.sh
. ./functions/deleteRecordatorio.sh
. ./functions/z_menu.sh
function getUsers(){
	string=$3
	totalidad=`expr length $string` #Guarda en una variable la longitud de la cadena introducida
	while true #bucle infinito
	do
		coma=`expr index $string ","` #Guarda la posicion de la primera ,
		if [ $coma -eq 0 ]
			then
				VALID_ID=$(getFilename) #GenerarID
				usuario=$string
				getRecordatorio  "$timeAndDate" "$1" "$2" $usuario
				finalString="$timeAndDate $usuario bash $ruta_script/"$tituloWithUnder"_"$VALID_ID".sh"
				addToCron
				break
		else
			let coma1=$coma+1
			let sincoma=$coma-1
			usuarioActual=`expr substr $string 1 $sincoma` #Encuentra un usuario			
			VALID_ID=$(getFilename) #GenerarID
			usuario=$usuarioActual
			getRecordatorio  "$timeAndDate" "$1" "$2" $usuario
			finalString="$timeAndDate $usuario bash $ruta_script/"$tituloWithUnder"_"$VALID_ID".sh"
			addToCron
			let totalidad=$totalidad-$coma
			string=`expr substr $string $coma1 $totalidad` #Modifica el string introducido para eliminar el usuario anterior
		fi
	done
}

