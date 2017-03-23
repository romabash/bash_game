#!/bin/bash

#Include randomNumber function to generate unique random number of specified length
source ./randomNumber.sh

#Clear playlog
$(: > playlog)

BRed='\033[1;31m'         # Red text
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
Reset='\033[0m'

message="${BGreen}Bulls${Reset} and ${BYellow}Cows"

#Generating Random number

level=4
number=($(randomNumber $level)) #set to array 

name="Player2"

#-----------------------------------------------------------------------

#Checking and comparing
bulls=0
count=0
until (($bulls >= $level)); do 

  tput clear
  tput cup 4 10 #put "cursor" at given location
  echo -e "$message${Reset}" #Echo the combined arguments 
  echo -e "\n"
  #echo ${number[*]}
  cat playlog

  read -p "Enter your guess " input
  
  guess=($(echo "$input" | grep -o .)) #Outer () to make array
  check=($(echo "${guess[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ')) #Remove duplicates and sets new array

  bulls=0
  cows=0

  if [[ $input == "quit" || $input == "q" ]]; then
    exit
  fi
  
  if (( ${#guess[@]} != $level )); then
    echo -e "${BRed}Make sure to use $level numbers${Reset}" >> playlog
  elif (( ${#guess[@]} != ${#check[@]} )); then
    echo -e "${BRed}Make sure to not duplicate numbers${Reset}" >> playlog
  else
    
    all_matches=0 #Find all matches first
    for i in ${guess[@]}; do 
      inArray $i ${number[@]}
      match=$?
        
      if (( $match == 0)); then #If number is in both arrays
        let all_matches+=1
      fi
    done 
      
    #Find number of bulls by looking at numbers in the same index 
    for x in ${!guess[@]}; do
      if (( ${guess[$x]} == ${number[$x]} )); then
        let bulls+=1
      fi
    done 
      
    cows=$(( all_matches - bulls )) #Find cows by subtracting
    
    if (($bulls == 0 && $cows == 0)); then
      echo -e "$input:\t${BRed}No matches${Reset}" >> playlog
    elif (($bulls == 4));then
      echo -e "$input:\t${BGreen}$bulls Bulls${Reset}" >> playlog
    else
      echo -e "$input:\t${BGreen}$bulls Bulls${Reset} and ${BYellow}$cows Cows${Reset}" >> playlog
    fi

    ((count++)) 

  fi
  
done #Ends untill loop - Game Won

#Final display
tput clear
tput cup 4 10 #put "cursor" at given location
echo -e "$message${Reset}" #Echo the combined arguments 
echo -e "\n"
cat playlog


if (($count == 1)); then 
  echo "YOU WON!!!  It took you 1 try"
else
  echo "YOU WON!!!  It took you $count tries"
fi

#-----------------------------------------------------------------------
#Saving High score:

if grep -i -q $name score; then #if Name with High score exists
  score=$(grep -i $name score | awk '{print $2}')

  if ((count < score)); then #check if current count is less than previous score
    $(sed -i "/$name/d" score)
    $(echo "$name $count" >> score) #delete old score and append new high score
  fi
else
  $(echo "$name $count" >> score)
fi

