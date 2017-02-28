#!/bin/bash
#Oscar Cobo Gomez
. ./functions/sintaxis.sh
. ./functions/addToCron.sh
. ./functions/users.sh
. ./functions/checkDate.sh
. ./functions/checkTimeFormat.sh
. ./functions/getFileName.sh
. ./functions/getRecordatorio.sh
. ./functions/createRecordatorio.sh
. ./functions/deleteRecordatorio.sh
. ./functions/z_menu.sh
. ./functions/listAll.sh
. ./functions/showHistory.sh
case $1 in
	-a)
		if [ "$USER" = "root" ] #Si el usuario es Root entrará en el bucle
			then
				if [ $# -eq 6 ] #Si se han establecido 6 parametros es que ha indicado algun usuario
					then 
						checkDate $2 $3 #tratemiento fecha y hora
						string "$4" #miramos que en el texto introducido no haya ';'
						string "$5" #miramos que en el texto introducido no haya ';'
						getUsers "$4" "$5" "$6" #empezar iteracion de usuarios y genera el recordatorio para cada uno de ellos
				fi
				if [ $# -eq 5 ] #Usuario root pero recordatorio para él mismo
					then
						checkDate $2 $3 #tratemiento fecha y hora
						string "$4" #miramos que en el texto introducido no haya ';'
						string "$5" #miramos que en el texto introducido no haya ';'
						VALID_ID=$(getFilename) #GenerarID
						usuario="root"
						getRecordatorio  "$timeAndDate" "$4" "$5" $usuario
						finalString="$timeAndDate $usuario bash $ruta_script/"$tituloWithUnder"_"$VALID_ID".sh"
						addToCron
				fi
		else
			if [ $# -eq 5 ]
				then 
					checkDate $2 $3 #tratemiento fecha y hora
					string "$4" #miramos que en el texto introducido no haya ';'
					string "$5" #miramos que en el texto introducido no haya ';'
					VALID_ID=$(getFilename) #GenerarID
					usuario=""
					getRecordatorio  "$timeAndDate" "$4" "$5" $usuario
					finalString="$timeAndDate bash $ruta_script/"$tituloWithUnder"_"$VALID_ID".sh"
					addToCron	
			else
				echo "La sintaxis introducida no es correcta, pruebe a ejecutar recordatorios -h"
			fi	
		fi
		;;
	-d)
		if [ $# -eq 2 ]
			then
				delete $2
		else
			echo "La sintaxis introducida no es correcta, pruebe a ejecutar recordatorios -h"
		fi
		;;

	-i)
		if [ $# -gt 1 ]; then
			echo "La sintaxis introducida no es correcta, pruebe a ejecutar recordatorios -h"
			exit 
		fi

		if [ $UID == '0' ]; then
			if [ -z $2 ]; then
				echo "Como root debes especificar una cuenta de usuario"
				echo "Uso: ./showHistory.sh <usuario>"
				exit
			else 
				if [ $2 != "-h" ]; then
					showHistory $2
				else 
					echo "Uso: ./showHistory.sh <usuario>"
					exit
				fi
			fi
		else
			if [[ -n $2 ]] && [[ $1 != $USER ]] && [[ $2 != "-h" ]]; then
				echo "No puedes ver el historial de otros usuarios"
				exit 
			else 
				if [[ -z $2 ]] && [[ $1 != "-h" ]]; then
					showHistory
				else 	
					echo "Uso: ./showHistory.sh"
					exit
				fi
			fi
		fi
		;;
	-l)
		if [ "$USER" = "root" ]
			then
				if [ $# -eq 2 ]
					then
						archivos=$(grepfiles "/home/$2")
						if [[ $archivos =~ \* ]]
							then
								echo "no se han encontrado recordatorios"
								exit
						else
							printtable "$archivos"
						fi
				else
					echo "Debes introducir un nombre de usuario"
					exit
				fi
		else
			if [[ $# -eq 2 ]] && [[ "$2" != "$USER" ]] 
				then
					echo "No puedes ver los recordatorios de otros usuarios"
					exit
			fi

			archivos=$(grepfiles ~)

			if [[ $archivos =~ \* ]]
				then
					echo "No se han encontrado recordatorios"
					exit
			else 
				printtable "$archivos"
			fi
		fi
		;;
	-c)
		echo "consultas"
		;;
	"")
		z_menu
		;;
	-h)
		echo ""
		echo "RECORDATORIOS"
		echo "es una orden para gestionar los recordatorios del usuario"
		echo "si se ejecuta sin ningun parametro se ejecutará con entrono grafico"
		echo "los parametros para utilizar son los siguientes:"
		echo -e "     -a: Añade un nuevo recordatorio"
		echo -e "                dd/mm/yyyy hh:mm \"Titulo Recordatorio\" \"Descripcion Recordatorio\""
		echo -e "     -d: Elimina el recordatorio que contiene la ID introducida."
		echo -e "                ID"
		echo -e "     -i: Muestra el historico de los recordatorios del usuario"
		echo -e "                [usuario]"
		echo -e "     -l: Lista los recordatorios pendientes"
		echo -e "                [usuario]"
		echo -e "     -c: consultar"
		echo -e "                sintaxis"
		;;
	*)
		echo "El parametro introducido no es correcto, pruebe a ejecutar recordatorios -h"
		;;
esac
