function checkTimeFormat()
{
	REGEX="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$"
		if [[ $1 =~ $REGEX ]]; then
	  		arrHora=(${1//:/ })
			hora=${arrHora[0]}
			if [ $hora -lt 10 ]
				#Quitamos el 0 a la izquierda
				then hora=${hora:1:2}
			else 
				hora=$hora
			fi
			minuto=${arrHora[1]}
			if [ $minuto -lt 10 ]
				#Quitamos el 0 a la izquierda
				then minuto=${minuto:1:2}
			else 
				minuto=$minuto
			fi
                time="$minuto $hora"
        
                #LLamamos a la funcion getTimeAndDate
                timeAndDate="$minuto $hora $fecha_s"
                echo $timeAndDate
                #getTimeAndDate "$minuto" "$hora" "$fecha_s"
	   else
            clear
  		    echo "El formato de la hora no es correcto, debe ser HH:MM"
            exit		
	   fi	    
}