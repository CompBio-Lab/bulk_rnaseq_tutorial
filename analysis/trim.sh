#!/bin/bash

file=$1
while read line; do
  IFS=' '
  read -ra newarr <<< "$line"
  java -jar /Trimmomatic-0.38/trimmomatic-0.38.jar PE -threads 4 ${newarr[0]} ${newarr[1]} \
	../results/trim/${newarr[2]}_paired_1.fastq ../results/trim/${newarr[2]}_unpaired_1.fastq \
  ../results/trim/${newarr[2]}_paired_2.fastq ../results/trim/${newarr[2]}_unpaired_2.fastq \
  ILLUMINACLIP:/Trimmomatic-0.38/adapters/TruSeq3-PE.fa:2:30:10:2:True LEADING:5 TRAILING:3 MINLEN:36 HEADCROP:12 
done < "${file}"
