#AUTOR -> MARCOS ARENA

#Funcion que da valor a las variables $titulo $descripcion $user -> introduce estos valores


function getRecordatorio() {

if [ $USER == root ]
    then
    titulo=$2
    descripcion=$3
    usuario=$4
    recordatorio="$1 \"$2\" \"$3\" $4"    
else
        titulo=$2
        descripcion=$3
        recordatorio="$1 \"$2\" \"$3\""        
fi


createRecordatorio "$titulo" "$descripcion"


}
