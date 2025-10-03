#!/bin/bash
#SBATCH -J nfcorernaseq
#SBATCH -p unlimitq
#SBATCH --mem=6G

module load bioinfo/Nextflow/25.04.0
module load devel/java/17.0.6

input=/home/fmt101/work/Project/samplesheet.csv
gtf=/home/fmt101/work/Project/annotation/Gadus_morhua.gadMor3.0.115.gtf

nextflow run nf-core/rnavar -profile genotoul -r 1.2.1 --input $input --outdir output/OUTDIR_rnavar --gtf $gtf --skip_baserecalibration
