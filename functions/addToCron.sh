#!/bin/bash

#idimpostor="$tituloWithUnder"_"$VALID_ID"
#Valor de la fecha recibido por la funcion de Marc.
#valor='50 10 5 5 5'
#ID de la tarea recibido por la funcion de Diego

function addToCron(){

    #Falta cambiar la variable $idimpostor por la de $id de la funcion de Diego.
    
	#valor3=`find ~/recordatorios/ -name "$VALID_ID".sh`
    
    #valor3='/home/marc/recordatorios/Examen_ASOP_Gv5gwQKY.sh'
    echo $finalString
    
    #echo $timeAndDate
    #exit
    #valor2="bash"
    #cadena="$timeAndDate $valor2 $ruta_script/"$tituloWithUnder"_"$VALID_ID".sh"
    #echo $cadena
    
	#Comprobamos si el usuario es root.
	if [ $USER = "root" ];
	    then
        #Añadimos los valores al archivo crontab del usuario root.
	    echo $finalString >> /etc/crontab    
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
            
            crontab -l | { cat; echo "$finalString"; } | crontab -
            echo "...done."
	        else
            crontab -l | { cat; echo "$finalString"; } | crontab -
            
	        
	    fi
    fi     
}
