#!/bin/bash

#Include randomNumber function to generate unique random number of specified length
source ./randomNumber.sh

#Generating Random number

level=4
number=($(randomNumber $level)) #set to array 
echo ${number[*]}

name="Player"

#-----------------------------------------------------------------------

#Checking and comparing
bulls=0
count=0
until (($bulls >= $level)); do 
   
  read -p "Enter your guess " input
  guess=($(echo "$input" | grep -o .)) #Outer () to make array
  check=($(echo "${guess[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ')) #Remove duplicates and sets new array

  bulls=0
  cows=0
  
  if (( ${#guess[@]} != $level )); then
    echo "Make sure to use $level numbers" 
  elif (( ${#guess[@]} != ${#check[@]} )); then
    echo "Make sure to not duplicate numbers" 
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
    
    echo "$input:	$bulls Bulls and $cows Cows"
    
    ((count++)) 
  fi
  
done #Ends untill loop - Game Won

if (($count == 1)); then 
  echo "YOU WON!!!  It took you 1 try"
else
  echo "YOUWON!!!  It took you $count tries"
fi

#-----------------------------------------------------------------------
#Saving High score:

if grep -i -q $name score; then
  score=$(grep -i $name score | awk '{print $2}')

  if ((count < score)); then
    $(sed -i "/$name/d" score)
    $(echo "$name $count" >> score)
  fi
else
  $(echo "$name $count" >> score)
fi

