#AUTOR -> DIEGO

# Funcion que genera una cadena alfanumerica de 8 caracteres
function generateID {
   id=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
   echo $id
}
