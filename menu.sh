#!/bin/bash

BRed='\033[1;31m'         # Red text
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
Reset='\033[0m'

cols=$(tput cols)
rows=$(tput lines)

message="${BGreen}Bulls${Reset} and ${BYellow}Cows"
 
input_length=${#message} #find the length

half_input_length=$(( $input_length / 2 )) #To center, get half of length
 
row_pos=$(( $rows / 4)) #Get 1/4 of row (height)
col_pos=$(( ($cols / 2) - $half_input_length )) #get get middle of width minus half of the length (each side)
 
tput clear #clear terminal
 
tput cup 4 10 #put "cursor" at given location
echo -e "$message${Reset}" #Echo the combined arguments

#Using the Select 
names="Play Quit"
PS3='Select character: '
 
select name in $names; do
  if [ $name == 'Quit' ]; then
    break
  fi
    bash game.sh
done


tput sgr0 #Turns bold and other changes off
tput cup $( tput lines ) 0 #Place the prompt at the bottom of the screen


