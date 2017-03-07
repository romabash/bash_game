#!/bin/bash

#num=$(( $RANDOM % 10 ))
#echo $num

number=()

#len=${#number[@]}

while (( ${#number[@]} < 4 )); do
  num=$(( $RANDOM % 10 ))
  echo $num
  for i in "${number[@]}"; do
    if [ "$i" -eq "$num" ]; then
      result="present"
    fi 
  done 
  if [ "$result" != "present" ]; then
    number+=($num)
  fi
done

echo ${number[*]}

