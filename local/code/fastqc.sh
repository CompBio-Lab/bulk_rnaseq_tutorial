#!/usr/bin/env bash

file=$1
OUTPUT=$2
echo $file
echo $OUTPUT
while read line; do
  IFS=' '
  read -ra newarr <<< "$line"
  echo ${newarr[0]}
  echo ${newarr[1]}
  fastqc -t 5 ${newarr[0]} -o $OUTPUT
  fastqc -t 5 ${newarr[1]} -o $OUTPUT
done < "${file}"

# https://home.cc.umanitoba.ca/~psgendb/doc/fastqc.help
# FASTQ_FILES=$(find $1 -name *.fastq.gz)
# echo $FASTQ_FILES
# OUTPUT=../results/fastqc
# mkdir -p $OUTPUT
# for file in $FASTQ_FILES
# do
#     echo $file
#     fastqc -t 5 $file -o $OUTPUT
# done