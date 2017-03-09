#!/bin/bash

#-----------------------------------------------------------------------

#Function to check if element is in array
#Takes 2 arguments: the element and expanded array
inArray(){
  local e #local varibale e 
  local arr="${@:2}" #Combines 2nd arg (expanded array) into one varibale  
     
  for e in $arr; do 
    if [[ "$e" == "$1" ]]; then 
      return 0 #Return 0 (True) 
    fi 
  done
  return 1 #Return 1 (False) otherwise
}

#-----------------------------------------------------------------------

number=() 
level=4 #How many numbers to play 

while (( ${#number[@]} < $level )); do
  num=$(( $RANDOM % 10 ))

  inArray $num ${number[@]} #Check if new Random num is already in array
  contains=$? #Assign return value of inArray(): 1 or False, not in array
  
  if (( $contains == 1 )); then
    number+=($num) #If not in array, add to number
  fi
done

echo ${number[*]}


#-----------------------------------------------------------------------
read -p "Enter a unique $level digit number " input 
guess=($(echo "$input" | grep -o .)) #Outer () to make array

echo ${guess[@]}

all_matches=0 #Find all matches first
for i in ${guess[@]}; do 
  inArray $i ${number[@]}
  match=$?
  
  if (( $match == 0)); then #If number is in both arrays
    let all_matches+=1
  fi
done

bulls=0 #Find number of bulls by looking at numbers in the same index 
for x in ${!guess[@]}; do
  if (( ${guess[$x]} == ${number[$x]} )); then
    let bulls+=1
  fi
done 

cows=$(( all_matches - bulls )) #Find cows by subtracting

echo "Total matches is $all_matches"
echo "Bulls: $bulls"
echo "Cows $cows"









