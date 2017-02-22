#!/bin/bash

stringZ="abc ABC123ABCabc"

hola=${stringZ/ /_}       # xyzABC123ABCabc
                              # Replaces first match of 'abc' with 'xyz'.

#echo ${stringZ//abc/xyz}      # xyzABC123ABCxyz
                              # Replaces all matches of 'abc' with # 'xyz'.

echo  ---------------
echo "$hola"               # abcABC123ABCabc
echo  ---------------
                              # The string itself is not altered!