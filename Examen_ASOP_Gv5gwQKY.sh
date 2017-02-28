#!/bin/bash
#Autor: German

cut -f 4 -d ';' ~/recordatorios/history.txt > ~/recordatorios/users.txt

lines=`wc -l < ~/recordatorios/history.txt`


for i in `cat ~/recordatorios/users.txt`
do
resultadonum=`echo $i | uniq -c | head -n 1 | sort | awk '{print $1}'`
resultadonom=`echo $i | uniq -c | head -n 1 | sort | awk '{print $2}'`


echo 'Usuario: ' $resultadonom
echo 'Numero de recordatorios: ' $resultadonum



while [ $resultadonum -gt 0 ]; do
	echo X
	let resultadonum=resultadonum-1
done
done
