#!/bin/bash
#SBATCH -p workq
#SBATCH --time=1-11:04:00 #1 jour et 11h

#Load binaries
module load bioinfo/SRA-Toolkit/3.0.2

vdb-config --prefetch-to-cwd;
prefetch SRR2045415;
prefetch SRR2045416;
prefetch SRR2045417;
fastq-dump --split-files SRR2045415;
fastq-dump --split-files SRR2045416;
fastq-dump --split-files SRR2045417;
gzip * -k;
mv SRR* fasta/ ;
