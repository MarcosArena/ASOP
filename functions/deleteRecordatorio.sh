#!/bin/bash
#Autor: German
#Comprobamos si es root, si es root eliminamos la linea del archivo contrab del root, si no lo es, eliminamos la linea del archivo de respaldo .cron.txt del usuario y ejecutamos crontab para actualizar el fichero.
function delete(){
fecha=`(date +'%d/%m/%Y %H:%S')` 
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
		echo "[DELETED];$1;;$USER;;$fecha" >> /recordatorios/historial/history.txt        
        	echo "[DELETED];$1;;$USER;;$fecha" >> ~/recordatorios/historial/history.txt
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
		#Añadimos linea a los history (cambiar formato?)
		echo "[DELETED];$1;;$USER;;$fecha" >> /recordatorios/historial/history.txt
		echo "[DELETED];$1;;$USER;;$fecha" >> ~/recordatorios/historial/history.txt
		
        	
	else
		echo "Error de formato, no ha introducido ninguna tarea para eliminar o la tarea no existe."
	fi
fi
}
	

