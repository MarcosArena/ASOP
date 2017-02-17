
function getRecordatorio() {

if [ $USER == root ]
    then
    titulo=$2
    descripcion=$3
    user=$4
    recordatorio="$1 \"$2\" \"$3\" $4"    
else
    if [ $5 ] 
        then echo "Para seleccionar un usuario, debes ser root."
             exit
    else
        titulo=$2
        descripcion=$3
        recordatorio="$1 \"$2\" \"$3\""        
    fi
fi
echo $recordatorio

createRecordatorio "$titulo" "$descripcion"

}