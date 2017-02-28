# Funcion que comprueba si el parametro pasado (id) existe como nombre de archivo
#Autor: Diego
function checkExists {
   if [ $(find ~/recordatorios/ -name *$1* ) ] ; then
      echo 1
   else
      echo 0
   fi
}
