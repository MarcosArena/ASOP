#!/bin/bash
. ./functions/sintaxis.sh
. ./functions/addToCron.sh
. ./functions/users.sh
. ./functions/checkDate.sh
. ./functions/checkTimeFormat.sh
. ./functions/getTimeAndDate.sh
. ./functions/generateID.sh
. ./functions/checkExists.sh
. ./functions/getFileName.sh
. ./functions/getRecordatorio.sh
. ./functions/createRecordatorio.sh
. ./functions/z_principal.sh
case $1 in
	-a)
		if [ "$USER" = "root" ] 
			then
				if [ $# -eq 6 ]
					then 
						checkDate $2 $3 #tratemiento fecha y hora
						string "$4" #miramos que en el texto introducido no haya ';'
						string "$5" #miramos que en el texto introducido no haya ';'
						getUsers "$4" "$5" "$6" #empezar itiracion con usuarios
				fi
				if [ $# -eq 5 ]
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
				echo "mal sintaxis"
			fi	
		fi
		;;
	-d)
		echo "eliminar"
		;;
	-m)
		echo "modificar"
		string "$5"
		string "$6"
		;;
	-i)
		echo "historico"
		;;
	-l)
		echo "listar"
		;;
	-c)
		echo "consultas"
		;;
	"")
		#no se si funciona/hay que cambiarlo por el menu
		bash ./functions/z_principal.sh
		;;
	-h)
		echo ""
		echo "es una orden para gestionar los recordatorios del usuario"
		echo "si se ejecuta sin ningun parametro se ejecutará con entrono grafico"
		echo "los parametros para utilizar son los siguientes:"
		echo -e "     -a: añadir"
		echo -e "                dd/mm/yyyy hh:mm" "Titulo Recordatorio " " Descripcion Recordatorio""
		;;
	*)
		echo "mal parametro"
		;;
esac
