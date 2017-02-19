#!/bin/bash
#Script de inicio para crear la estructura si no esta creada.
#Para añadir el script de inicio hay que mover el archivo a /etc/.init.d y hacer un update-rc.d script.sh defaults


if [ "$USER" = "root" ];
	    then
        if [ ! -f "~/recordatorios/" ]; 
	        then
            mkdir "~/recordatorios/"
            echo "...done."
        fi
#Lo mismo pero con un usuario normal.
else
        if [ ! -f "~/recordatorios/" ]; 
	        then
            mkdir "~/recordatorios/"
            echo "...done."    
        fi
fi


