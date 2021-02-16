#!/bin/bash

#SBATCH --job-name=symlinks_JA
#SBATCH -A ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=1

cd /data/class/ecoevo283/javelarb
mkdir DNASeq RNASeq ATACSeq

#Sym links for DNA
for i in /data/class/ecoevo283/public/RAWDATA/DNAseq/*; do ln -s ${i} DNASeq/$(basename ${i}); done

#Sym links for RNAseq data. Did not copy metadata files.
find /data/class/ecoevo283/public/RAWDATA/RNAseq/ -type f -name '*fastq.gz' > RNASeq/filepaths.txt
while read i; do ln -s ${i} RNASeq/$(basename ${i}); done < RNASeq/filepaths.txt

#Sym links for ATACseq data.
for i in /data/class/ecoevo283/public/RAWDATA/ATACseq/*; do ln -s ${i} ATACSeq/$(basename ${i}); done
cd ATACSeq/
for i in *.gz; do mv ${i} ${i:33}; done

module load fastqc/0.11.9
fastqc ATACSeq/P020_R1.fq.gz ATACSeq/P020_R2.fq.gz

