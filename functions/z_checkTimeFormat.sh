function z_checkTimeFormat()
{
    #Comprobamos el formato de la hora introducida $time.
	REGEX="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$";
    
    #Si el formato es correcto...
	if [[ $1 =~ $REGEX ]]; then
            #Convertimos el string $time en un array y los separamos en $hora y $minuto
	  		arrHora=(${1//:/ })
			hora=${arrHora[0]}
            minuto=${arrHora[1]}
            
            #Si $hora es menor que 10, quitamos el 0 a la izquierda
			if [ $hora -lt 10 ]
				then hora=${hora:1:2}
			else 
				hora=$hora
			fi
            
            #Lo mismo para $minuto			
			if [ $minuto -lt 10 ]
				then minuto=${minuto:1:2}
			else 
				minuto=$minuto
			fi
            #Llamamos a la funcion getTimeAndDate
            z_getTimeAndDate $fecha $
	else
    
        #Si el formato es incorrecto, volvemos a llamar a getTime()
  		zenity --warning --text="El formato de la hora no es correcto, debe ser HH:MM"
		z_getTime
	fi	
	
}