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

	echo " "
	echo " Lista de recordatorios de $USER"
	echo " "
	printf "%-3s %-30s %-60s\n" "" "Titulo" "Descripcion"
	echo " "

	for r in $1
	do
		titulo=$(grep -Eho '^\#Titulo:\s(.*)' $r | cut -d ' ' -f 2-)
		desc=$(grep -Eho '^\#Descripcion:\s(.*)' $r | cut -d ' ' -f 2-)
		printf "%-3s %-30s %-60s\n" " *" "${titulo:0:30}" "${desc:0:60}"
	done

	echo " "
	echo " Fin de lista de recordatorios"
	echo " "
}

###Todo esto está comentado porque se introduzco en el parámetro -l de recordatorios.sh

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
