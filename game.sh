#!/bin/bash

#Red Background with Red Text to create a block
x="\033[0;101m\033[1;91m======\e[0m"
#echo -e $x

cols=$(tput cols)
rows=$(tput lines)

middle_row=$((rows/2))
middle_col=$(( (cols/2)-(${#x}/2) ))

for ((i=1; i<=5; i++)); do
  tput clear

  tput cup $((10+$i)) $middle_col
  echo -e ${x}
  sleep 0.5
done

tput sgr0
tput cup $(tput lines) 0

