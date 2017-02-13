#Ejemplo de calendario Zenity -> Marcos 
#!/bin/bash

time=`zenity --entry --title="Hora" --text="Introduce la hora" \
	--entry-text="00:00"`

function checkTimeFormat()
{
	REGEX="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$"

	if [[ $1 =~ $REGEX ]]; then
  		arrHora=(${1//:/ })
		hora=${arrHora[0]}
		minuto=${arrHora[1]}
		echo $hora
		echo $minuto
	else
  		zenity --warning --text="El formato de la hora no es correcto, debe ser HH:MM"
	fi
return
}
 
checkTimeFormat $time
