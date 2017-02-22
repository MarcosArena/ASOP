#!/bin/bash
#Titulo: Examen ASOP\n \n
#Descripcion: No traer portátidfdl \n
rec=`zenity 	--info 	   --title="Examen ASOP" 	   --text="\n Titulo: Examen ASOP \n \n Descripcion: No traer portátidfdl"        --width=500         --height=300`
      case 0 in
                0)
                    echo Comenzar instalación...;;
                1)
                    echo Has detenido la instalación...;;
                2)
                    echo Ha ocurrido un error inesperado...;;
            esac 
