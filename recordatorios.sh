#!/bin/bash
#Oscar Cobo Gomez
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
		if [ "$USER" = "root" ] #Si el usuario es Root entrará en el bucle
			then
				if [ $# -eq 6 ] #Si se han establecido 6 parametros es que ha indicado algun usuario
					then 
						checkDate $2 $3 #tratemiento fecha y hora
						string "$4" #miramos que en el texto introducido no haya ';'
						string "$5" #miramos que en el texto introducido no haya ';'
						getUsers "$4" "$5" "$6" #empezar iteracion de usuarios y genera el recordatorio
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
		#bash ./functions/z_principal.sh
		echo "entorno grafico zenity"
		;;
	-h)
		echo ""
		echo "es una orden para gestionar los recordatorios del usuario"
		echo "si se ejecuta sin ningun parametro se ejecutará con entrono grafico"
		echo "los parametros para utilizar son los siguientes:"
		echo -e "     -a: añadir"
		echo -e "                Añade un nuevo recordatorio."
		echo -e "                dd/mm/yyyy hh:mm \"Titulo Recordatorio\"   \"Descripcion Recordatorio\""
		echo ""
		echo -e "     -d: eliminar"
		echo -e "                Elimina el recordatorio que contiene la ID introducida."
		echo -e "                ID"
		echo ""
		echo -e "     -m: modificar"
		echo -e "                Modifica un recordatorio existente."
		echo -e "                sintaxis para modificar"
		echo ""
		echo -e "     -i: history"
		echo -e "                Muestra un historico de los recordatorios del usuario, si el que lo ejecuta"
		echo -e "                es un usuario root, podrá indicar que historico desea visualizar."
		echo -e "                [usuario]"
		echo -e "     -l: listar"
		echo -e "                descripcion"
		echo -e "                sintaxis"
		echo -e "     -c: consultar"
		echo -e "                descripcion"
		echo -e "                sintaxis"
		;;
	*)
		echo "El parametro introducido no es correcto, pruebe a ejecutar recordatorios -h"
		;;
esac
