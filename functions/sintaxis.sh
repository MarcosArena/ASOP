#Oscar Cobo Gomez
function string(){
	contador=0 #establecemos un contador para utilizar en el bucle
	contador1=1
	longitud=`expr length "$1"` #establecemos una variable llamada longitud que guarda la longitud del string introducido
	while [ $contador -lt $longitud ] #bucle que hara itiraciones hasta que el contador previamente establecido sea igual a longitud
	do
		comprobar=`expr substr "$1" $contador1 1` #Comprobamos si el caracter actual es un ';'
		if [ "$comprobar" = ";" ] #Si se trata de un ';' se acabará el bucle y mostrara un error.
			then
				echo "No se puede introducir el caracter ';'"
				exit
		fi
		let contador=$contador+1
		let contador1=$contador1+1
	done
}
