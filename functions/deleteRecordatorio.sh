
#Comprobamos si es root, si es root eliminamos la linea del archivo contrab del root, si no lo es, eliminamos la linea del archivo de respaldo .cron.txt del usuario y ejecutamos crontab para actualizar el fichero.
echo $USER
if [ $USER="root" ];
        then
	archive=`find ~/recordatorios/ -name "$2*".sh`
	if [ ! -z "$2" ] && [ ! -z "$archive" ];
	then
		echo $USER
		sed -i "/${2}/d" /etc/crontab
		echo $archive
		#Eliminamos el script de la carpeta recordatorios.
		#rm $archive
		echo "...eliminando tarea programada."
		echo "...done."
		echo "root"
	else
		echo "Error de formato, no ha introducido ninguna tarea para eliminar la tarea no existe."
	fi
else
	if [ ! -z "$2" ] && [ ! -z "$archive" ]; 
	then
		sed -i "/${2}/d" ~/recordatorios/.cron.txt
		crontab ~/recordatorios/.cron.txt
		#rm $archive
		echo "...eliminando tarea programada."
		echo "...done."
		echo "user"
	else
		echo "Error de formato, no ha introducido ninguna tarea para eliminar la tarea no existe."
	fi
fi

