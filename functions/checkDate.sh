
#AUTOR -> MARCOS ARENA

# Funcion al que le pasamos la fecha introducida, comprueba que es una fecha valida, y devuelve la fecha
# con el formato deseado dia mes dia_semana

function checkDate() {
 clear	
    
    #Antes de poder utilizar el comando date, debemos modificar la fecha para que sea mm/dd/YYYY    
    #Creamos un array a partir de la fecha introducida por el usuario. (El separador es / )
	arrFecha=(${1//// })
	
	# mm/dd/YY   
	dia=${arrFecha[0]};
    mes=${arrFecha[1]};
    year=${arrFecha[2]};
    
   	fecha=${arrFecha[1]}"/"${arrFecha[0]}"/"${arrFecha[2]}
    
    
    # Obtenemos la fecha actual mm/dd/YYYY %H:M
    # los segundos desde 1970-01-01 00:00:00  hasta hoy
    hoy=`(date +'%m/%d/%Y %H:%M')`    
    desde_hoy=$( date -d "$hoy" +'%s')
    
    
    # Obtenemos la fecha y la hora introducidas por el usuario mm/dd/YYYY %H:M
    # los segundos desde 1970-01-01 00:00:00  hasta la fecha introducida
    hora_y_fecha_introd="$fecha $2" 
    desde_fecha=$( date -d "$hora_y_fecha_introd" +'%s')
    
    #Si la conversión ha funcionado...
		case $? in
			0)
				# Si han pasado menos segudos desde la fecha introducida que desde la
                # fecha actual...
                if [ $desde_fecha -lt $desde_hoy ]; then    
                    echo "La fecha introducida es anterior a la actual."  
                exit
                fi
                #Obtenemos el formato deseado para el string -> dia mes dia_semana <-
                fecha_s=$( date -d $fecha +'%d %m %w')
                # LLamamos a la funcion checkTimeFormat
                checkTimeFormat $2;;
			1)
				echo "El formato de la fecha \"$1\" no es correcta"
                exit
                ;;

		esac         

}
