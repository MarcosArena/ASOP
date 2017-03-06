# AUTOR -> MARCOS ARENA

# Función que recibe como parámetro una hora (HH:MM)
# Recibe [ -z ] ($2) si es llamada desde -z_getTime

function checkTimeFormat()
{
	REGEX="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$"
		if [[ $1 =~ $REGEX ]]; then
            #Separamos la hora de los minutos
	  		arrHora=(${1//:/ })
			hora=${arrHora[0]}
            minuto=${arrHora[1]}
            
            #Quitamos el 0 a la izquierda del a hora. ($hora:1:2 -> Desde el caracter 1 al 2)
			if [ $hora -lt 10 ]				
				then hora=${hora:1:2}
			else 
				hora=$hora
			fi
			
            #Quitamos el 0 a la izquierda de los minutos.
			if [ $minuto -lt 10 ]				
				then minuto=${minuto:1:2}
			else 
				minuto=$minuto
			fi
            
            # Juntamos todos los valores con el formato correcto en $timeAndDate, que despues usaremos 
            # Para la función crear el $finalString para ejecutar addToCron.
            timeAndDate="$minuto $hora $fecha_s"
                
                if [ $2 ]
                    then 
                    timeAndDate="$minuto $hora $fecha_s"
                    z_getRecordatorio
                else
                    :
                fi
                
                echo $timeAndDate
                #getTimeAndDate "$minuto" "$hora" "$fecha_s"
	   else
       
        if [ $2 ]
        then
            clear
  		    zenity --warning --text="El formato de la hora no es correcto, debe ser HH:MM"
            z_getTime
        else
            clear
  		    echo "El formato de la hora no es correcto, debe ser HH:MM"
            exit	
        fi            	
	   fi	    
}