#!/bin/bash

#Include randomNumber function to generate unique random number of specified length
source ./randomNumber.sh

#Generating Random number

level=4
number=($(randomNumber $level)) 
echo ${number[*]}

#-----------------------------------------------------------------------

bulls=0
cows=0
#Input Validation

while (( $bulls != $level )); do
  read -p "Enter a unique $level digit number " input 
  guess=($(echo "$input" | grep -o .)) #Outer () to make array
  
  if (( ${#guess[@]} != $level )); then
    read -p "Enter a unique $level digit number " input 
    guess=($(echo "$input" | grep -o .)) #Outer () to make array
  fi
  
  check=($(echo "${guess[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))
  
  if (( ${#guess[@]} != ${#check[@]} )); then
    read -p "Enter a UNIQUE $level digit number " input 
    guess=($(echo "$input" | grep -o .)) #Outer () to make array
  fi
  
  echo ${guess[@]}
 
  #Checking and comparing
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
done  
  echo "Total matches is $all_matches"
  echo "Bulls: $bulls"
  echo "Cows $cows"










