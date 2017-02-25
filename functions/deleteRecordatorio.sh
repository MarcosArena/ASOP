#!/bin/bash
#Comprobamos si es root, si es root eliminamos la linea del archivo contrab del root, si no lo es, eliminamos la linea del archivo de respaldo .cron.txt del usuario y ejecutamos crontab para actualizar el fichero.
function delete(){
archive=`find ~/recordatorios/ -name "*$1".sh`
if [ "$USER" == "root" ]
	then
	if [ ! -z "$archive" ]
		then
		sed -i "/${1}/d" /etc/crontab
		echo $archive
		#Eliminamos el script de la carpeta recordatorios.
		rm $archive
		echo "...eliminando tarea programada."
		echo "...done."
		echo "root"
	else
		echo "Error de formato, no ha introducido ninguna tarea para eliminar la tarea no existe."
		echo "user"
	fi
else
	if [ ! -z "$archive" ]
	then
		sed -i "/${1}/d" ~/recordatorios/.cron.txt
		crontab ~/recordatorios/.cron.txt
		#Eliminamos el script de la carpeta recordatorios.
		rm $archive
		echo "...eliminando tarea programada."
		echo "...done."
	else
		echo "Error de formato, no ha introducido ninguna tarea para eliminar o la tarea no existe."
	fi
fi
}
	

