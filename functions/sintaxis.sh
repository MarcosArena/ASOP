#Oscar Cobo Gomez
function string(){
	contador=0
	contador1=1
	longitud=`expr length "$1"`
	while [ $contador -lt $longitud ]
	do
		comprobar=`expr substr "$1" $contador1 1`
		if [ "$comprobar" = ";" ]
			then
				echo "No se puede introducir el caracter ';'"
				exit
		fi
		let contador=$contador+1
		let contador1=$contador1+1
	done
}
