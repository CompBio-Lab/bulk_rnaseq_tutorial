#!/bin/bash

file=$1
OUTPUT=$2
while read line; do
  IFS=' '
  read -ra newarr <<< "$line"
  fastqc -t 5 ${newarr[0]} -o $OUTPUT
  fastqc -t 5 ${newarr[1]} -o $OUTPUT
done < "${file}"