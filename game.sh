#!/bin/bash

#Function to check in element is in array
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

number=()

len=${#number[@]}

while (( ${#number[@]} < 4 )); do
  num=$(( $RANDOM % 10 ))

  inArray $num ${number[@]}
  contains=$?
  
  if (( $contains == 1 )); then
    number+=($num)  
  fi
done

echo ${number[*]}

