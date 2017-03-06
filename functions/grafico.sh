#!/bin/bash

#Autor: German

function grafico(){

	#Agregamos las lineas del history que empiezan por CREATED al archivo users.txt
	cat /recordatorios/historial/history.txt | grep "\<CREATED\>"  > /recordatorios/historial/.users.txt

	#Buscamos unicamente el cuarto campo que es el que contiene el nombre del usuario y lo agregamos al archivo text.txt
	cat /recordatorios/historial/.users.txt | cut -f 4 -d ';' | sort > /recordatorios/historial/.test.txt

	#Ordenamos los usuarios, hacemos uso del comando uniq -c para contar los recordatorios y lo agregamos al archivo users2.txt
	cat /recordatorios/historial/.test.txt | sort | uniq -c | sort > /recordatorios/historial/.users2.txt

	IFS=$'\n'

	#Funcion que nos muestra el simbolo * por cada recordatorio del usuario.
	printf_new(){
	  num=$1
	   v=$(printf "%-${num}s" "*")
	   echo "${v// /*}"
	}

	#Hacemos uso del printf para mostrar los datos con tabulaciones.
	echo " "
		echo " "
		printf "%-3s %-30s %-60s\n" "" "Usuario" "Recordatorios"
	echo " "

	#Bucle for donde por cada linea del archivo users2.txt coge el primer parametro que pertenece al numero de * que vamos a mostrar y el 		segundo
	#parametro que pertenece al nombre del usuario.
	for r in `cat /recordatorios/historial/.users2.txt`; do
		estrellas=`echo $r | awk '{print $1}'`
		usuario=`echo $r | awk '{print $2}'`

		#Asignamos los * totales a la variable test para poder concatenar la salida con las tabulaciones
		test=`printf_new $estrellas`

		#Mostramos el resultado final con el nombre del usuario y su respectivo resultado de estrellas.
		printf "%-3s %-30s %-60s\n" "" "$usuario" "$test"
	done
	#Una vez terminado eliminamos los archivos auxiliares utilizados.
	rm /recordatorios/historial/.users.txt /recordatorios/historial/.test.txt /recordatorios/historial/.users2.txt
}
grafico
