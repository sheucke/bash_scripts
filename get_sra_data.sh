#!/bin/bash

# activate conda env
eval "$(conda shell.bash hook)"
conda activate rna-seq

# get input data (remove header and take only first field)
VAR=$(tail -n +2 SraRunTable.txt | cut -d ',' -f 1)

# This is a loop for downloading the data

for i in ${VAR}
  do
    if [ -f ${i}.fastq.gz ]
      then
        echo "${i} already downloaded"
    else
      echo "(o) Downloading SRA entry: ${i}" 
      # downloading SRA entry and compress, remove line qual
      fastq-dump --gzip --defline-qual '+' ${i}
      echo "(o) Done downloading ${i}"
    fi
  done