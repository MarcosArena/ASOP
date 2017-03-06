#!/bin/bash
#Autor: Diego
function showHistory {
	clear

	if [[ -n $1 ]] && [[ $UID -eq 0 ]]; then
		usuario=$1
	else 
		usuario=$USER
	fi

	histfile=/home/$usuario/recordatorios/historial/history.txt
	eleccion="x"
	shopt -s nocasematch

	echo ""
	echo " Historial de tareas de "$usuario
	echo ""

	while [[ $eleccion == "x" ]]
	do
		echo -n " ¿Filtrar historial? (s/n) "
		read eleccion

		case $eleccion in
			"s" ) opcion="s";;
			"n" ) ;;
			*) eleccion="x";;
		esac
	done

	echo ""
	if [[ $opcion == "s" ]]; then
		echo -n " Introduzca una regex a buscar: "
		read regex
	else
		echo " Mostrando todo el historial..."
		regex=".*"
	fi
	
	echo ""
	printf "%-3s %-18s %-12s %-30s %-12s %-12s\n" "" "Fecha" "Accion" "Titulo" "Creado por" "Creado para"
	echo ""

	eventos=$(cat $histfile)
	numeventos=$(cat $histfile| wc -l)
	numcreados=0
	numedit=0
	numelim=0
	cont=0

	OIFS=$IFS
	IFS=$'\n'
	
	for r in $eventos
	do

		if [[ $r =~ $regex ]]; then

			fecha="$(echo $r | cut -d";" -f 6,7)"
			titulo=$(echo $r | cut -d ";" -f 3)
			accion=$(echo $r | cut -d";" -f 1)
			de=$(echo $r | cut -d";" -f 4)
			para=$(echo $r | cut -d";" -f 5)
			cont=$[cont+1]
		
			if [ -z $para ]; then
				para=$usuario
			fi
	
			case $accion in 
				"[CREATED]") let numcreados++ ;;
				"[EDIT]")	let numedit++ ;;
				"[DELETED]") let numelim++ ;;
				*);;
			esac

			printf "%-3s %-18s %-12s %-30s %-12s %-12s\n" "${cont}" "${fecha:0:18}" "${accion:0:20}" "${titulo:0:30}" "${de:0:12}" "${para:0:12}"
		fi

	done

	if [ $cont -le 0 ]; then
		echo " No se han encontrado eventos que coincidan con el patrón de búsqueda"
	else
		IFS=$OIFS
		echo " "
		echo " Total: "$cont" (Creados: "$numcreados", ediciones: "$numedit", eliminaciones: "$numelim")"
	fi

	echo ""
	echo " Fin de lista de recordatorios"
	echo ""

}


#if [ $# -gt 1 ]; then
#	echo "Solo se admite un parametro para esta orden"
#	echo "Uso: ./showHistory.sh [usuario]"
#	exit 
#fi

#if [ $UID == '0' ]; then
#	if [ -z $1 ]; then
#		echo "Como root debes especificar una cuenta de usuario"
#		echo "Uso: ./showHistory.sh <usuario>"
#		exit
#	else 
#		if [ $1 != "-h" ]; then
#			showHistory $1
#		else 
#			echo "Uso: ./showHistory.sh <usuario>"
#			exit
#		fi
#	fi
#else
#	if [[ -n $1 ]] && [[ $1 != $USER ]] && [[ $1 != "-h" ]]; then
#		echo "No puedes ver el historial de otros usuarios"
#		exit 
#	else 
#		if [[ -z $1 ]] && [[ $1 != "-h" ]]; then
#			showHistory
#		else 
#			echo "Uso: ./showHistory.sh"
#			exit
#		fi
#	fi
#fi
