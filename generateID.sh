#!/bin/bash

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

VALID_ID=$(getFilename)
echo $VALID_ID
