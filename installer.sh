#!/bin/bash
#Autor: German
if [ "$USER" = "root" ];
	    then
        #Creamos un usuario que nos permita añadirlo al cron.deny y asi poder modificar el cron.
        useradd recordatorios

        #Creamos el archivo cron.deny y añadimos al usuario creado anteriormente.
        touch /etc/cron.deny
        echo recordatorios >> /etc/cron.deny

	#Creamos la estructura necesaria en la raiz del sistema
	 mkdir /recordatorios
	 chmod 777 /recordatorios/
	 mkdir /recordatorios/historial
	 chmod 777 /recordatorios/historial
	 mkdir /recordatorios/scripts
	#Movemos nuestro script dentro de la estructura
	 mv functions/ /recordatorios
	 #chmod 777 /recordatorios/functions/*
	 mv recordatorios.sh /recordatorios/
	 chmod 777 /recordatorios/recordatorios.sh
	 

else
echo "Se necesitan privilegios de administrador para realizar la instalación de esta herramienta"
fi
