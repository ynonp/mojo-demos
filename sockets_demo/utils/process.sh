#!/bin/bash

word="$1"
while true
do
  word=$(echo $word | tr a-z b-za)
  echo $word
  [[ $word == "$1" ]] && break
  sleep 0.5 
done
