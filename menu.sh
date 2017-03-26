#!/bin/bash

BRed='\033[1;31m'         # Red text
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
Reset='\033[0m'

message="${BGreen}Bulls${Reset} and ${BYellow}Cows${Reset}"

#Function to clear screen and display at the right row and column
display(){ 
  tput clear #clear terminal
  tput cup 4 10 #put "cursor" at given location
  echo -e "$message" #Title
}

display

#Using the Select 
menu="Play Scores Quit"
PS3='Select option: '
 
select choice in ${menu}; do
  case $choice in
    "Quit")
      break
      ;;
    "Play")
      bash game.sh
      echo -e "\n"
      read -n 1 -s -p "Press any key to continue"
      display
      ;;
    "Scores")
      cat score
      echo -e "\n"
      read -n 1 -s -p "Press any key to continue"
      display
      ;;
    esac
done

tput sgr0 #Turns bold and other changes off
tput cup $( tput lines ) 0 #Place the prompt at the bottom of the screen


