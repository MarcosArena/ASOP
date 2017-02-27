
#AUTOR -> MARCOS ARENA

#Funcion que da valor a las variables $titulo $descripcion $usuario

function getRecordatorio() {
. ./functions/createRecordatorio.sh
if [ $USER == root ]
    then
    titulo=$2
    descripcion=$3
    usuario=$4
else
    titulo=$2
    descripcion=$3         
fi

createRecordatorio "$titulo" "$descripcion"

}
