#!/bin/bash
. ./functions/z_getDate.sh
. ./functions/z_checkTimeFormat.sh
. ./functions/z_getTimeAndDate.sh
. ./functions/generateID.sh
. ./functions/checkExists.sh
. ./functions/getFileName.sh
. ./functions/z_getRecordatorio.sh
. ./functions/z_createRecordatorio.sh
. ./functions/z_getTime.sh


VALID_ID=$(getFilename)

z_getDate

echo $recordatorio 
echo $finalstring
bash ~/recordatorios/"$VALID_ID".sh
#getTimeAndDate 
#getRecordatorio