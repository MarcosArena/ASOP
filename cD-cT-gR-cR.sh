#!/bin/bash

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
	fecha=$( date -d $fecha +'%d %b %w')	
      
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
                getTimeAndDate "$time $fecha"
	   else
            clear
  		    echo "El formato de la hora no es correcto, debe ser HH:MM"
            exit		
	   fi	    
}

function getTimeAndDate() {
    timeAndDate="$1 $2 $3"
    #echo $timeAndDate
}

# Funcion que genera una cadena alfanumerica de 8 caracteres
function generateID {
   id=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
   echo $id
}

# Funcion que comprueba si el parametro pasado (id) existe como nombre de archivo
function checkExists {
   if [ $(find ~/recordatorios/ -name *$1* ) ] ; then
      echo 1
   else
      echo 0
   fi
}

# Funcion principal que genera un id unico con comprobacion
function getFilename {
   while true; do
      ID=$(generateID)
      EXIST=$(checkExists $ID)
      if [ $EXIST -eq 0 ]; then
         echo $ID
         break
      fi
   done
}


function getRecordatorio() {

if [ $USER == root ]
    then
    nombre=$2
    descripcion=$3
    user=$4
    recordatorio="$1 \"$2\" \"$3\" $4"    
else
    if [ $5 ] 
        then echo "Para seleccionar un usuario, debes ser root."
             exit
    else
        nombre=$2
        descripcion=$3
        recordatorio="$1 \"$2\" \"$3\""        
    fi
fi
echo $recordatorio
exit
createRecordatorio "$nombre" "$descripcion"

}

function createRecordatorio() {
#str_fecha=$( date -d $fecha +'%d_%m_%Y')	


echo "Descipción del recordatorio:" > .temp.txt
echo · "$descripcion :" >> .temp.txt

    archivo=`dirname $0`/.temp.txt

    echo "rec=\`zenity 	--text-info \
		--title=\"$nombre\" \
		--filename=$archivo \
		--checkbox='Visto'\`" > ~/recordatorios/"$USER"_"$VALID_ID"_"$dia"_"$mes"_"$year".sh
    echo "
        if [ $rec==0 ]
        then    echo "Autoeliminar..."
        else    echo "Has cancelado la operación"
        fi
        " >> ~/recordatorios/"$USER"_"$VALID_ID"_"$dia"_"$mes"_"$year".sh
    
    if [ $?=0 ]
        then echo Se ha creado el script: $HOME/recordatorios/"$USER"_"$VALID_ID"_"$dia"_"$mes"_"$year".sh
    else
        echo "Error al crear el script."
    fi
}
clear
VALID_ID=$(getFilename)



#Comprobamos si el usuario que ha ejecutado la orden es root
if [ $USER == "root" ]
    then
    usuario=$6    
else
    if [ $6 ] 
        then echo "Debes ser root para seleccionar un usuario"
        exit
    else
        usuario=       
    fi
fi



checkDate $2 $3

#Comprobamos si el usuario que ha ejecutado la orden es root
if [ $USER == "root" ]
    then
    usuario=$6    
else
    if [ $6 ] 
        then echo "Debes ser root para seleccionar un usuario"
        exit
    else
        usuario=       
    fi
fi

getRecordatorio  "$timeAndDate" "$4" "$5" $usuario

echo $nombre $descripcion

#bash $HOME/recordatorios/"$USER"_"$VALID_ID"_"$dia"_"$mes"_"$year".sh

#echo $recordatorio

#echo $timeAndDate





