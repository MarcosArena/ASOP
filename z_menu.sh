#!/bin/bash

#AUTOR -> MARCOS ARENA

list=`zenity --list --radiolist --print-column='3' --separator=',' --title="Seleccione un opción" --text="Elija una opción para empezar."\
	--width=400 --height=400 \
	--column="" --column="Opción" --column="a"\
    --hide-column='3' \
	"" "Crear un recordatorio" "crear" \
	"" "Borrar un recordatorio" "borrar" \
    "" "Editar un recordatorio" "editar"
	`

case $list in 
	"crear") 
		bash ./z_add.sh;;	
	"borrar") 	
		bash ./z_delete.sh;;
	"editar")
		bash ./z_edit.sh;;
    "")
        clear
        zenity --question --title="Atención" --text="¿Seguro que deseas cancelar la operación?"	
			if [ $? = 0 ]	
				then 
                clear
                exit
			else
				bash ./z_menu.sh
			fi
        echo "No has seleccionado ninguna acción.";;
esac