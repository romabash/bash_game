#!/bin/bash

#Red Background with Red Text to create a block
x="\033[0;101m\033[1;91m======\e[0m"
#echo -e $x

cols=$(tput cols)
rows=$(tput lines)

middle_row=$((rows/2))
middle_col=$(( (cols/2)-(${#x}/2) ))


#Player Green Bg with Green text
y="\033[0;102m\033[1;92m======\e[0m"
y_pos=$middle_col
left='\[D'
right='\[C'
SUCCESS=0

for ((x_pos=1; x_pos<=10; x_pos++)); do
  tput clear

  tput cup $x_pos $middle_col
  echo -e ${x}
 

  tput cup $rows $y_pos
  echo -e ${y}
  
  read -rsn3 input
  echo -n "$input" | grep "$left"
  if [ "$?" -eq $SUCCESS ]; then
    let y_pos-=10
  fi
  echo -n "$input" | grep "$right"
  if [ "$?" -eq $SUCCESS ]; then
    let y_pos+=10
  fi

#if ["$input" = "a"]; then
#  $((++y_pos))
#  echo $input
#elif ["$input" = "s"]; then
#  $((--y_pos))  
#fi

  sleep 0.5
done


tput sgr0
tput cup $(tput lines) 0


