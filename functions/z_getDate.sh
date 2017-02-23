function z_getDate () {

    hoy_dia=$(date +'%d')
    hoy_mes=$(date +'%m')
    
    #Dialogo de Zenity que pide una fecha y la transf. en %d(dia);%m(mes);w(dia_semana)
	fecha=`zenity --calendar \
		--title='Seleccione una fecha' \
		--text='Haga click en una fecha para seleccionarla.' \
		--date-format='%d;%m;%w' \
		--day=$hoy_dia --month=$hoy_mes --year=2017`

	if [ $fecha ]
		then
		#Cambiamos las ";" por un espacio. (Si no, --date-format del zenity da error). 
		fecha=${fecha//;/ }
		fecha="${fecha}"
		z_getTime
			
	else
        #Pedimos confirmación para cancelar.
		zenity --question --title="Atención" --text="¿Seguro que deseas cancelar la operación?"	
			if [ $? = 0 ]	
				then clear 
                exit
			else
                #Llamamos a la función getDate
				z_getDate
			fi		
	fi
 }