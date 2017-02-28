#AUTOR -> DIEGO ORTIZ

# Funcion principal que genera un id unico con comprobacion
. ./functions/generateID.sh
. ./functions/checkExists.sh
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
