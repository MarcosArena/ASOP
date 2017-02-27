#!/bin/bash

function showHistory {
	clear

	if [[ -n $1 ]] && [[ $UID -eq 0 ]]; then
		usuario=$1
	else 
		usuario=$USER
	fi

	histfile=/home/$usuario/recordatorios/historial/history.txt
	
	echo ""
	echo " Historial de tareas de "$usuario
	echo ""

	printf "%-3s %-18s %-12s %-30s %-12s %-12s\n" "" "Fecha" "Accion" "Titulo" "Creado por" "Creado para"
	echo " "

	eventos=$(cat $histfile)
	numeventos=$(cat $histfile| wc -l)
	numcreados=0
	numedit=0
	numelim=0

	OIFS=$IFS
	IFS=$'\n'

	for r in $eventos
	do
		fecha="$(echo $r | cut -d";" -f 6,7)"
		titulo=$(echo $r | cut -d ";" -f 3)
		accion=$(echo $r | cut -d";" -f 1)
		de=$(echo $r | cut -d";" -f 4)
		para=$(echo $r | cut -d";" -f 5)

		if [ -z $para ]; then
			para=$usuario
		fi

		case $accion in 
			"[CREATED]") let numcreados++ ;;
			"[EDIT]")	let numedit++ ;;
			"[DELETE]") let numelim++ ;;
			*);;
		esac

		printf "%-3s %-18s %-12s %-30s %-12s %-12s\n" " *" "${fecha:0:18}" "${accion:0:20}" "${titulo:0:30}" "${de:0:12}" "${para:0:12}"
	done

	IFS=$OIFS
	echo " "
	echo " Número total de eventos: "$numeventos" (Creados: "$numcreados", ediciones: "$numedit", eliminaciones: "$numelim")"
	echo " "
	echo " Fin de lista de recordatorios"
	echo " "

}


if [ $# -gt 1 ]; then
	echo "Solo se admite un parametro para esta orden"
	echo "Uso: ./showHistory.sh [usuario]"
	exit 
fi

if [ $UID == '0' ]; then
	if [ -z $1 ]; then
		echo "Como root debes especificar una cuenta de usuario"
		echo "Uso: ./showHistory.sh <usuario>"
		exit
	else 
		if [ $1 != "-h" ]; then
			showHistory $1
		else 
			echo "Uso: ./showHistory.sh <usuario>"
			exit
		fi
	fi
else
	if [[ -n $1 ]] && [[ $1 != $USER ]] && [[ $1 != "-h" ]]; then
		echo "No puedes ver el historial de otros usuarios"
		exit 
	else 
		if [[ -z $1 ]] && [[ $1 != "-h" ]]; then
			showHistory
		else 
			echo "Uso: ./showHistory.sh"
			exit
		fi
	fi
fi
