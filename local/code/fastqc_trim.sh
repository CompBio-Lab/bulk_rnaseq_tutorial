#!/usr/bin/env bash

# https://home.cc.umanitoba.ca/~psgendb/doc/fastqc.help
echo $1
FASTQ_FILES=$(find $1 -name *.fastq)
echo $FASTQ_FILES
OUTPUT=results/fastqc
mkdir -p $OUTPUT
for file in $FASTQ_FILES
do
    echo $file
    fastqc -t 5 $file -o $OUTPUT
done