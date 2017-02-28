#!/bin/bash

#AUTOR -> MARCOS ARENA
. ./functions/z_add.sh
. ./functions/z_delete.sh
function z_menu(){
list=`zenity --list --radiolist --print-column='2' --separator=',' --title="Seleccione un opción" --text="Elija una opción para empezar."\
	--width=400 --height=400 \
	--column="" --column="Opción" --column="a"\
    --hide-column='2' \
	"" "Crear un recordatorio" "crear" \
	"" "Borrar un recordatorio" "borrar"
	`

case $list in 
	"crear") 
		z_add;;	
	"borrar") 	
		z_delete;;
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
}
