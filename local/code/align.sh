#!/bin/bash

file=$1
while read line; do
  IFS=' '
  read -ra newarr <<< "$line"
  hisat2 -q --rna-strandness FR -x data/grch38/genome \
  --summary-file results/align/${newarr[2]}_summary.txt \
  -1 results/trim/${newarr[2]}_paired_1.fastq \
  -2 results/trim/${newarr[2]}_paired_2.fastq | samtools sort -o results/align/${newarr[2]}.bam
done < "${file}"
