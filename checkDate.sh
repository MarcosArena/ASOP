function checkDate() {
 clear	
	#Creamos un array a partir de la fecha introducida por el usuario. (El separador es / )
	arrDate=(${1//// })
	
	#Antes de poder utilizar el comando date, debemos modificar la fecha para que sea mm/dd/YYYY
	fecha=${arrDate[1]}"/"${arrDate[0]}"/"${arrDate[2]}
	
	#Obtenemos el formato deseado para el string dia mes dia_semana
	fecha=$( date -d $fecha +'%d %m %w')	

	#Si la conversión ha funcionado...
		case $? in
			0)
				checkTimeFormat $2;;
			1)
				echo "La fecha no es correcta";;

		esac
}

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
	else
  		echo "El formato de la hora no es correcto, debe ser HH:MM"
		
	fi	
	
}

checkDate $1 $2

case $minuto in
	0)
		timeAndDate="$minuto $hora $fecha";;
	1)
		echo "Han ocurrido errores.";;

esac

echo $timeAndDate


