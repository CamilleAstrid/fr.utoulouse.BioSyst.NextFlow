#!/bin/bash
#SBATCH -p workq
#SBATCH --time=1-11:00:00 #1 jour et 11h

#Load binaries
module purge
module load bioinfo/SRA-Toolkit/3.0.2

vdb-config --prefetch-to-cwd;
prefetch SRR2045415;
prefetch SRR2045416;
prefetch SRR2045417;
fastq-dump --gzip --split-files SRR2045415;
fastq-dump --gzip --split-files SRR2045416;
fastq-dump --gzip --split-files SRR2045417;

mkdir fasta;
mkdir genome;
mkdir annotation;
mkdir output;

cd annotation;
wget https://ftp.ensembl.org/pub/release-115/gtf/gadus_morhua/Gadus_morhua.gadMor3.0.115.gtf.gz ;
gunzip Gadus_morhua.gadMor3.0.115.gtf.gz
rm Gadus_morhua.gadMor3.0.115.gtf.gz

cd .. ;
mv SRR* fasta/ ;

mv slurm* output/ ;