
function checkDate() {
 clear	
	 
    #Creamos un array a partir de la fecha introducida por el usuario. (El separador es / )
	arrFecha=(${1//// })
	
	#Antes de poder utilizar el comando date, debemos modificar la fecha para que sea mm/dd/YYYY
	fecha=${arrFecha[1]}"/"${arrFecha[0]}"/"${arrFecha[2]}
	dia=${arrFecha[0]};
    mes=${arrFecha[1]};
    year=${arrFecha[2]};
    
    #echo $fecha
    
	#Obtenemos el formato deseado para el string dia mes dia_semana
	fecha_s=$( date -d $fecha +'%d %b %w')	
      
	#Si la conversión ha funcionado...
		case $? in
			0)
				checkTimeFormat $2;;
			1)
				echo "El formato de la fecha \"$1\" no es correcta"
                exit
                ;;

		esac
}
