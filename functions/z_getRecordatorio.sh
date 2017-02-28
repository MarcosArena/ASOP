#AUTOR -> MARCOS ARENA
function z_getRecordatorio() {
	titulo=`zenity --entry --title="Título" --text="Título del recordatorio" \
		--entry-text=""`
	if [ "$titulo" ]
        
		then 
        titulo="$titulo"
        descripcion=`zenity --entry --title="Descripción" --text="Añade información al recordatorio." \
			--entry-text="Descripción..."`	
			if [ $? = 0 ]
				then 
                descripcion=$descripcion                
                #then tituloyDescripcion="$titulo $descripcion"
				#echo $tituloyDescripcion
			else
				zenity --question --title="Atención" --text="¿Seguro que deseas cancelar la operación?"	
			if [ $? = 0 ]	
				then clear 
                exit
			else
				z_getRecordatorio
			fi
			fi		
	else zenity --question --title="Atención" --text="¿Seguro que deseas cancelar la operación?"	
			if [ $? = 0 ]	
				then clear 
                exit
			else
				z_getRecordatorio
			fi
	fi  		

createRecordatorio "$titulo" "$descripcion" "$usuario"
}
