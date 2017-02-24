function z_getTime () {
    
    #Pedimos al usuario que introduzca una hora en formato HH:MM y lo almacenamos en la variable $time
	time=`zenity --entry --title="Hora" --text="Introduce la hora" \
		--entry-text="00:00"`
        
        #Comprobamos si se ha introducido.
		if [ $time ]
            #Llamamos a la función checkTimeFormat para compbrobar que el formato es HH:MM
			then checkTimeFormat $time -z
		else
			zenity --question --title="Atención" --text="¿Seguro que deseas cancelar la operación?"	
			if [ $? = 0 ]	
				then clear 
                exit
			else
				z_getTime
			fi
		fi
return
}