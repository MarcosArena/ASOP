#/bin/bash





#
# Grepfiles: busca los recordatorios almacenados en la ruta especificada
# 
# Parametro: ruta inicial (/home/<user> o /etc/crontab/root)
# Salida: ruta completa
#
# Autor: Diego
#

function grepfiles {
	ruta="$1/recordatorios/scripts/*.sh"
	echo $ruta
}







#
# Printtable: parsea cada archivo de recordatorio y busca datos concretos
# para mostrarlos ordenadamente en una tabla
# 
# Parametro: lista de archivos de recordatorios
# Salida: tabla con los campos de cada recordatorio formateado en tabla
#
# Autor: Diego
#

function printtable {

	eleccion="x"
	ahora=$(date +'%s')
	while [[ $eleccion == "x" ]]
	do
		echo " Indique los recordatorios a listar"
		echo -n " t: todos - p: pendientes - f: finalizados. Opcion: "
		read eleccion

		case $eleccion in
			"t" ) eleccion="t";;
			"p" ) eleccion="p";;
			"f" ) eleccion="f";;
			*) eleccion="x";;
		esac
	done

	echo " "
	echo " Lista de recordatorios de $USER"
	echo " "
	printf "%-3s %-20s %-30s %16s\n" "" "Titulo" "Descripcion" "Fecha"
	echo " "

	for r in $1
	do
		titulo=$(grep -Eho '^\#Titulo:\s(.*)' $r | cut -d ' ' -f 2-)
		desc=$(grep -Eho '^\#Descripcion:\s(.*)' $r | cut -d ' ' -f 2-)
		fecha=$(grep -Eho '^\#Fecha:\s([0-9]+)' $r | cut -d ' ' -f 2-)
		if [ -z $fecha ]; then
			fecha=0
		fi
		print=0
		
		if [[ $eleccion == "t" ]]; then
			print=1
		elif [[ $eleccion == "p" ]] && [[ $fecha -gt $ahora ]]; then
			print=1
		elif [[ $eleccion == "f" ]] && [[ $fecha -lt $ahora ]]; then
			print=1
		else
			print=0
		fi

		if [ $print == 1 ]; then
			fechalegible=$(date -d @$fecha +'%H:%M %d/%m/%Y')
			printf "%-3s %-20s %-30s %16s\n" " *" "${titulo:0:20}" "${desc:0:30}" "${fechalegible:0:16}"
		fi
	done

	echo " "
	echo " Fin de lista de recordatorios"
	echo " "
}






#if [ $UID == '0' ] 
#then



#	if [ -z $1 ]
#	then
#		echo "Debes introducir un nombre de usuario"
#		exit
#	fi
	
#	archivos=$(grepfiles "/home/$1")
	
#	if [[ $archivos =~ \* ]]
#	then
#		echo "No se han encontrado recordatorios"
#		exit
#	else 
#		printtable "$archivos"
#	fi

#else


#	if [[ -n $* ]] && [[ $* -ne "$USER" ]]
#	then
#		echo "No puedes ver los recordatorios de otros usuarios"
#		exit
#	fi

#	archivos=$(grepfiles ~)

#	if [[ $archivos =~ \* ]]
#	then
#		echo "No se han encontrado recordatorios"
#		exit
#	else 
#		printtable "$archivos"
#	fi


#fi


