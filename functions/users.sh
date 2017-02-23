#!/bin/bash
. ./functions/getRecordatorio.sh
. ./functions/createRecordatorio.sh
. ./functions/addToCron.sh
function getUsers(){
	string=$3
	totalidad=`expr length $string`
	while true
	do
		coma=`expr index $string ","`
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
			usuarioActual=`expr substr $string 1 $sincoma`			
			VALID_ID=$(getFilename) #GenerarID
			usuario=$usuarioActual
			getRecordatorio  "$timeAndDate" "$1" "$2" $usuario
			finalString="$timeAndDate $usuario bash $ruta_script/"$tituloWithUnder"_"$VALID_ID".sh"
			addToCron
			let totalidad=$totalidad-$coma
			string=`expr substr $string $coma1 $totalidad`
		fi
	done
}

