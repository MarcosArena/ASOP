#!/bin/bash

if [ "$USER" = "root" ];
	    then
        #Provisional: Creamos un usuario que nos permita añadirlo al cron.deny y asi poder modificar el cron.
        useradd recordatorios

        #Creamos el archivo cron.deny y añadimos al usuario creado anteriormente.
        touch /etc/cron.deny
        echo recordatorios >> /etc/cron.deny

        #Añadimos el script de inicio que comprobara si esta creada la estructura, si no lo esta la creara.
        mv /home/user/checkStructure.sh /etc/init.d/
        chmod +x /etc/init.d/checkStructure.sh
        sudo update-rc.d checkStructure.sh defaults

        #Añadimos el directorio donde se encontrara nuestro script a PATH para hacerlo accesible desde cualquier parte
        PATH="$PATH:/home/user/recordatorios/ASOP-master/functions"

else
echo "Se necesitan privilegios de administrador para realizar la instalación de esta herramienta"
fi
