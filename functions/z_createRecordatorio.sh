function z_createRecordatorio() {
#str_fecha=$( date -d $fecha +'%d_%m_%Y')	

    echo "Titulo: $titulo\n \n" > ~/recordatorios/"$VALID_ID".sh
    echo "Descripcion: $descripcion \n" >> ~/recordatorios/"$VALID_ID".sh
    
    echo "Titulo: $titulo" > ~/recordatorios/"$VALID_ID".sh
    echo "Descripcion: $descripcion" > ~/recordatorios/"$VALID_ID".sh
    
    echo "rec=\`zenity 	--info \
		--title=\"$titulo\" \
		--text=\"\n Titulo: $titulo \n \n Descripcion: $descripcion\"\
        --width=500 \
        --height=300\`" > ~/recordatorios/"$VALID_ID".sh
    echo " case $? in
	0)
		echo Comenzar instalación...;;
	1)
		echo Has detenido la instalación...;;
	2)
		echo Ha ocurrido un error inesperado...;;
esac    " >> ~/recordatorios/"$VALID_ID".sh
    
    if [ $?=0 ]
        then echo Se ha creado el script: $HOME/recordatorios/"$VALID_ID".sh
    else
        echo "Error al crear el script."
    fi
}