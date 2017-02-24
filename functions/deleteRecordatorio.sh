
#Comprobamos si es root, si es root eliminamos la linea del archivo contrab del root, si no lo es, eliminamos la linea del archivo de respaldo .cron.txt del usuario y ejecutamos crontab para actualizar el fichero.
if [$USER=="root" ]
        then

	sed -i '/$VALID_ID/d' /etc/crontab

   	echo "...eliminando tarea programada."
        echo "...done."
else
        sed -i '/$VALID_ID/d' ~/recordatorios/.cron.txt
        crontab ~/recordatorios/.cron.txt
        echo "...eliminando tarea programada."
        echo "...done."
fi
