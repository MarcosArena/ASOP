#! /bin/sh
#Script de inicio para crear la estructura si no esta creada.
#Para añadir el script de inicio hay que mover el archivo a /etc/.init.d y hacer un update-rc.d script.sh defaults

case "$1" in

start)
	if [ ! -d ~/recordatorios ]; then
		mkdir ~/recordatorios
		mkdir ~/recordatorios/historial
		mkdir ~/recordatorios/scripts
	fi
	;;
*)
	;;
esac
