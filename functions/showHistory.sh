#!/bin/bash

function showHistory {

	histfile=~/recordatorios/historial/history.txt
	clear
	echo ""
	echo " + Historial de tareas de "$USER" + "
	echo ""

	printf "%-3s %-18s %-12s %-30s %-12s %-12s\n" "" "Fecha" "Accion" "Titulo" "Creado por" "Creado para"
	echo " "

	eventos=$(cat $histfile)
	numeventos=$(cat $histfile| wc -l)

	OIFS=$IFS
	IFS=$'\n'

	for r in $eventos
	do
		fecha="$(echo $r | cut -d";" -f 6,7)"
		titulo=$(echo $eventos | cut -d ";" -f 3)
		accion=$(echo $eventos | cut -d";" -f 1)
		de=$(echo $eventos | cut -d";" -f 4)
		para=$(echo $eventos | cut -d";" -f 5)

		printf "%-3s %-18s %-12s %-30s %-12s %-12s\n" " *" "${fecha:0:18}" "${accion:0:20}" "${titulo:0:30}" "${de:0:12}" "${para:0:12}"
	done

	IFS=$OIFS
	echo " "
	echo " Número total de eventos: "$numeventos
	echo " "
	echo " Fin de lista de recordatorios"
	echo " "

}


showHistory