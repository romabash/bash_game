#!/bin/bash

#Set up the controls (left and right arrows)
left='\[D'
right='\[C'
SUCCESS=0
#----------------------------------------------

#Red Background with Red Text to create a block
block="\033[0;101m\033[1;91m======\e[0m"
#Green Background with Green Text to create player
player="\033[0;102m\033[1;92m======\e[0m"

cols=$(tput cols) 	#number of columns
rows=$(tput lines) 	#number of rows

middle_row=$((rows/2))	#half of height
middle_col=$(( (cols/2)-(${#block}/2) ))	

player_pos=$middle_col	#Position player in middle of screen

#---------------------------------------------

while true; do
  tput clear

  tput cup $block_pos $middle_col
  echo -e ${block}

  tput cup $rows $player_pos
  echo -e ${player}


  read -t 0.1 -rsn3 input
  echo -n "$input" | grep "$left"
  if [ "$?" -eq $SUCCESS ]; then
    let player_pos-=10
  fi
  echo -n "$input" | grep "$right"
  if [ "$?" -eq $SUCCESS ]; then
    let player_pos+=10
  fi

  # sleep 0.5
  let block_pos+=1

  if [[ $block_pos == $rows && $middle_col == $player_pos ]]; then
    break
  fi
done

tput sgr0
tput cup $(tput lines) 0
