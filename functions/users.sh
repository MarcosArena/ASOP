#!/bin/bash
#Oscar Cobo Gomez
. ./functions/addToCron.sh
. ./functions/getRecordatorio.sh
. ./functions/createRecordatorio.sh

function getUsers(){
	string=$3 #guardamos los usuarios introducidos en una variable
	totalidad=`expr length $string` #Guarda en una variable la longitud de la cadena introducida
	while true #bucle infinito
	do
		coma=`expr index $string ","` #Guarda la posicion de la primera ,
		if [ $coma -eq 0 ] #si no se encuentra ninguna , en el string entrará en el if
			then
				#bloque de codigo para crear recordatorio
				VALID_ID=$(getFilename) #GenerarID
				usuario=$string
				getRecordatorio  "$timeAndDate" "$1" "$2" $usuario
				finalString="$timeAndDate $usuario bash $ruta_script/"$tituloWithUnder"_"$VALID_ID".sh"
				addToCron
				break #rompemos el bucle
		else
			let coma1=$coma+1 #sumamos 1 a la posición de la , para no contar con ella
			let sincoma=$coma-1 #reestamos 1 a la posicion de la , para no cogerla al cojer el usuario
			usuarioActual=`expr substr $string 1 $sincoma` #Encuentra un usuario
			#bloque de codigo para crear recordatorio
			VALID_ID=$(getFilename) #GenerarID
			usuario=$usuarioActual
			getRecordatorio  "$timeAndDate" "$1" "$2" $usuario
			finalString="$timeAndDate $usuario bash $ruta_script/"$tituloWithUnder"_"$VALID_ID".sh"
			addToCron
			let totalidad=$totalidad-$coma #restamos el valor del primer usuario a la longitud del string
			string=`expr substr $string $coma1 $totalidad` #Modifica el string introducido para eliminar el usuario anterior
		fi
	done
}

