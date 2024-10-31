#!/bin/bash

file=$1
while read line; do
  IFS=' '
  read -ra newarr <<< "$line"
  featureCounts -p -a data/Homo_sapiens.GRCh38.112.gtf \
  -o results/counts/${newarr[2]}_featureCounts.txt results/align/${newarr[2]}.bam
done < "${file}"