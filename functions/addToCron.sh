#!/bin/bash

. generateID.sh
generateID
idimpostor='12345678'
#Valor de la fecha recibido por la funcion de Marc.
valor='50 10 5 5 5'
#ID de la tarea recibido por la funcion de Diego

function addToCron(){

    #Falta cambiar la variable $idimpostor por la de $id de la funcion de Diego.
    
	valor3=`find ~/recordatorios/ -name "$idimpostor"`
    cadena="$valor $USER $valor3"
    echo $cadena
	#Comprobamos si el usuario es root.
	if [ $USER = "root" ];
	    then
        #Añadimos los valores al archivo crontab del usuario root.
	    echo $1 $USER $valor3 >> /etc/crontab    
	    echo "...done."
	    
	else
	    #Si no es root, comprobamos si tiene creado un archivo cron.
	    if [ ! -f "/var/spool/cron/crontabs/$USER" ]; 
	        then
	        #Si no tiene un archivo le creamos un archivo con el parametro -u
            echo "Creando archivo crontab para el usuario: $USER"
            echo "...done."
		    crontab -u $USER ~/recordatorios/crontabsample.txt
            #Introducimos los valores dentro del archivo.
            echo "Añadiendo la tarea."
            
            crontab -l | { cat; echo "$cadena"; } | crontab -
            echo "...done."
	        else
            crontab -l | { cat; echo "$cadena"; } | crontab -
            
	        
	    fi
    fi     
}

addToCron
