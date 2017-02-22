
function getRecordatorio() {

if [ $USER == root ]
    then
    titulo=$2
    descripcion=$3
    user=$4
    recordatorio="$1 \"$2\" \"$3\" $4"    
else
        titulo=$2
        descripcion=$3
        recordatorio="$1 \"$2\" \"$3\""        
fi

#echo $recordatorio

createRecordatorio "$titulo" "$descripcion"

}