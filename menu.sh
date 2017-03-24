#!/bin/bash

BRed='\033[1;31m'         # Red text
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
Reset='\033[0m'

message="${BGreen}Bulls${Reset} and ${BYellow}Cows${Reset}"
 
tput clear #clear terminal
 
tput cup 4 10 #put "cursor" at given location
echo -e "$message" #Title

#function menu(){
#  echo "1)  Play Game"
#  echo "2)  Instructions"
#  echo "3)  Quit"
#}
#menu

#read -p "Select option " option
#
#until (( $option == 3 )); do
#  if (( $option == 1 )); then
#    bash game.sh
#  elif (( $option == 2 )); then
#    cat instructions
#  elif (( $option == 3)); then
#    break
#  else
#    read -p "Select option " option 
#  fi
#done

#Using the Select 
menu="Play Quit"
PS3='Select option: '
 
select choice in $menu; do
  case $choice in
    "Quit")
      break
      ;;
    "Play")
      bash game.sh
      ;;
    esac
done

tput sgr0 #Turns bold and other changes off
tput cup $( tput lines ) 0 #Place the prompt at the bottom of the screen


