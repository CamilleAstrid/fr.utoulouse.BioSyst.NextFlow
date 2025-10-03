# Sandbox

# Echantillons

## SRR2045415
* [trace NCBI](https://trace.ncbi.nlm.nih.gov/Traces/?view=run_browser&page_size=10&acc=SRR2045415&display=metadata)
* run : SRR2045415
* experiment : SRX1044005
    * 1 ILLUMINA (Illumina HiSeq 2000) run : 22.4M spots, 4.5G bases, 2.8Gb downloads
* biosample : SAMN02944940
* bioproject : PRJNA256972
* sra study : SRP058865


Information sur NCBI :
* [site NCBI](https://www.ncbi.nlm.nih.gov/search/all/?term=SRR2045415)
* Accession : PRJNA625442
* Gadus morhua [Taxonomy ID: 8049]
* Cod ovary
* sra : https://www.ncbi.nlm.nih.gov/sra/?term=SRR2045415


## SRR2045416

* [site NCBI](https://www.ncbi.nlm.nih.gov/search/all/?term=SRR2045415)
* Accession : PRJNA256972
* Gadus morhua [Taxonomy ID: 8049]
* Cod brain
* sra : https://www.ncbi.nlm.nih.gov/sra/?term=SRR2045416
* SRX1044006 : 1 ILLUMINA (Illumina HiSeq 2000) run
    * 36.5M spots
    * 7.3G bases
    * 4.7Gb downloads

## Recherche des fichiers dans les banques de données sur Genobioinfo

Recherche d'un fichier déjà existant dans la base de données du NCBI
```bash
ls -R ../../../bank/ncbi/genbank/ | grep -i -e 'SRX1044005' -e 'PRJNA625442' -e 'SRR2045415'
```

Utilisation du script *bank_info.sh* ([genotoul](https://bioinfo.genotoul.fr/index.php/faq/banks_faq/))
```bash
bank_info.sh -a
```
145 banques disponibles dont une nommée : `ensembl_gadus_morhua_genome`

## Format SRA
[source](https://www.ncbi.nlm.nih.gov/sra)

Sequence Read Archive (SRA) data, available through multiple cloud providers and NCBI servers, is the largest publicly available repository of high throughput sequencing data. The archive accepts data from all branches of life as well as metagenomic and environmental surveys. SRA stores raw sequencing data and alignment information to enhance reproducibility and facilitate new discoveries through data analysis.

### SRA toolkit
[How to use prefetch and fasterq-dump to extract FASTQ-files from SRA run accessions (github)](https://github.com/ncbi/sra-tools/wiki/08.-prefetch-and-fasterq-dump#how-to-use-prefetch-and-fasterq-dump-to-extract-fastq-files-from-sra-run-accessions)

[How can I download and convert SRA dataset ?
](https://bioinfo.genotoul.fr/index.php/faq/bioinfo_tips_faq/?highlight=sratoolkit)
<i>
with a SRA run id (eg SRR1045854) type :

* create ncbi directory:
```bash
mkdir ~/work/ncbi
```
* create link :
```bash
ln -s ~/work/ncbi ~/ncbi
```
* Load module:
```bash
module load bioinfo/sratoolkit.2.8.2-1
```
* download data :
```bash
prefetch SRR1045854
```
Your data will be available ~/work/ncbi/public/sra/SRR1045854.sra
* convert sra to fastq
```bash
fastq-dump ~/wor/ncbi/public/sra/SRR1045854.sra
```

After conversion, remove .sra file to save disk space.
You should use file from ENA as the protocol is much much much faster and files are already in fastq format.
</i>


# code
```bash
cd work
mkdir Project
```

## Récupération des données
1. FILE SRA_accession_list.txt
```bash
nano SRA_accession_list.txt
```
```plain text
SRR2045415
SRR2045416
SRR2045417
```

2. FILE sratoolkit.sh
```bash
nano sratoolkit.sh
```
```bash
#!/bin/bash
#SBATCH -p workq
#SBATCH --time=1-11:04:00 #1 jour et 11h

#Load binaries
module load bioinfo/sratoolkit.2.8.2-1

fastq-dump --split-files SRR2045415;
fastq-dump --split-files SRR2045416;
fastq-dump --split-files SRR2045417;
```
3. LANCEMENT
```bash
sbatch sratoolkit.sh
```
```bash
seff <job number>
```

RESULT 1
```bash
seff 25034554
-------------------------------------------------
Job ID: 25034554
Cluster: genobioinfo
User/Group: fmt101/formation
State: FAILED (exit code 127)
Cores: 1
CPU Utilized: 00:00:00
CPU Efficiency: 0.00% of 00:00:03 core-walltime
Job Wall-clock time: 00:00:03
Memory Utilized: 0.00 MB (estimated maximum)
Memory Efficiency: 0.00% of 2.00 GB (2.00 GB/core)
```

modification FILE sratoolkit.sh
```bash
#!/bin/bash
#SBATCH -p workq
#SBATCH --time=1-11:04:00 #1 jour et 11h

#Load binaries
module load bioinfo/SRA-Toolkit/3.0.2

fastq-dump --split-files SRR2045415;
fastq-dump --split-files SRR2045416;
fastq-dump --split-files SRR2045417;
```

RESULT 2
```bash
seff 25034628
-------------------------------------------------
Job ID: 25034628
Cluster: genobioinfo
User/Group: fmt101/formation
State: COMPLETED (exit code 0)
Cores: 1
CPU Utilized: 00:09:36
CPU Efficiency: 10.94% of 01:27:43 core-walltime
Job Wall-clock time: 01:27:43
Memory Utilized: 291.25 MB
Memory Efficiency: 14.22% of 2.00 GB
```

4. RECUPERATION DES DONNEES
```bash
mkdir annotation
mkdir genome
mkdir fasta
mkdir output
mv slurm* output/
mv *.fastq fasta/
```

5. ZIP DES FASTQ FILES
```bash
gzip * -k &
```
```bash
jobs # permet de savoir quel job est en train de tourner et son état
```

## Essaie avec *prefetch* avant *fastq-dump*
On va suivre à la lettre les indications inscrites sur le site [GenoToul Bioinfo](https://bioinfo.genotoul.fr/index.php/faq/bioinfo_tips_faq/?highlight=sratoolkit)
```bash
mkdir ncbi
cd ncbi
ln -s ~/work/Project/ncbi/ ~/../../bank/ncbi/
-------------------------------------------------
ln: failed to create symbolic link '/home/fmt101/../../bank/ncbi/ncbi': Permission denied
```
```bash
module load bioinfo/sratoolkit.2.8.2-1
-------------------------------------------------
ERROR: Unable to locate a modulefile for 'bioinfo/sratoolkit.2.8.2-1'
```
Bon les deux premières étapes ne sont pas concluantes...
```bash
search_module sratoolkit
search_module SRA
-------------------------------------------------
bioinfo/SRA-Toolkit/3.0.2
bioinfo/Transrate/1.0.3
bioinfo/Transrate/1.0.3_for_drap
```
On maintenant suivre les indications sur le [dépôt GitHub](https://github.com/ncbi/sra-tools/wiki/08.-prefetch-and-fasterq-dump#how-to-use-prefetch-and-fasterq-dump-to-extract-fastq-files-from-sra-run-accessions)
```bash
module load bioinfo/SRA-Toolkit/3.0.2
vdb-config --prefetch-to-cwd
prefetch SRR2045415
-------------------------------------------------
2025-10-03T09:43:21 prefetch.3.0.2: Current preference is set to retrieve SRA Normalized Format files with full base quality scores.
2025-10-03T09:43:21 prefetch.3.0.2: 1) Downloading 'SRR2045415'...
2025-10-03T09:43:21 prefetch.3.0.2: SRA Normalized Format file is being retrieved, if this is different from your preference, it may be due to current file availability.
2025-10-03T09:43:21 prefetch.3.0.2:  Downloading via HTTPS...
2025-10-03T09:45:46 prefetch.3.0.2:  HTTPS download succeed
2025-10-03T09:45:50 prefetch.3.0.2:  'SRR2045415' is valid
2025-10-03T09:45:50 prefetch.3.0.2: 1) 'SRR2045415' was downloaded successfully
```
Téléchargement du fichier .sra rapide. Lancement de l'étape la plus longue, la récupération du fichier .fastq depuis .sra .
```bash
nano test.sh
```
```bash
#!/bin/bash
#SBATCH -p workq
#SBATCH --time=1-11:04:00 #1 jour et 11h

fastq-dump --split-files SRR2045415;
```
```bash
sbatch test.sh
seff 25051715
-------------------------------------------------
Job ID: 25051715
Cluster: genobioinfo
User/Group: fmt101/formation
State: COMPLETED (exit code 0)
Cores: 1
CPU Utilized: 00:02:06
CPU Efficiency: 13.58% of 00:15:28 core-walltime
Job Wall-clock time: 00:15:28
Memory Utilized: 285.52 MB
Memory Efficiency: 13.94% of 2.00 GB
```

update FILE *sratoolkit.sh*
```bash
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
gzip * -k; #-k permet de conserver les fichiers d'origine
mv SRR* fasta/ ;
```

update FILE *test.sh* pour automatiser le téléchargement des données et leur compression au format .gz .
```bash
#!/bin/bash
#SBATCH -p workq
#SBATCH --time=1-11:04:00 #1 jour et 11h

#Load binaries
module load bioinfo/SRA-Toolkit/3.0.2

vdb-config --prefetch-to-cwd;
prefetch SRR2045415;
fastq-dump --split-files SRR2045415;
gzip * -k; #-k permet de conserver les fichiers d'origine
mv SRR* fasta/ ;
```
✅

Maintenant, ...

On remarque que cela permet de télécharger les .fastq mais pas les .gtf (.gff). Dans la recherche des paramètres sur le [site nf-core/rnavar](https://nf-co.re/rnavar/1.2.1/parameters/), il y a une option -genome dans la commande Nextflow run rnavar. Cependant, on ne trouve pas la clef de notre génome d'intérêt. Nous allons donc devoir utiliser le .gtf .

Il faut donc trouver comment récupérer le fichier.

Ce [site](https://www.unthsc.edu/school-of-biomedical-sciences/wp-content/uploads/sites/13/RNA-Seq_Hu.pdf) propose de récupérer le gtf file depuis Ensembl. Depuis cette [page du site Ensembl](https://www.ensembl.org/info/about/species.html) on peut récupérer le numéro du génome de *Gadus morhua* (gadMor3.0, GCA_902167405.1). On peut également récupérer le lien permet l'accès au fichier gtf.

```bash
wget https://ftp.ensembl.org/pub/release-115/gtf/gadus_morhua/Gadus_morhua.gadMor3.0.115.gtf.gz
-------------------------------------------------
--2025-10-03 13:25:43--  https://ftp.ensembl.org/pub/release-115/gtf/gadus_morhua/Gadus_morhua.gadMor3.0.115.gtf.gz
Resolving ftp.ensembl.org (ftp.ensembl.org)... 193.62.193.169
Connecting to ftp.ensembl.org (ftp.ensembl.org)|193.62.193.169|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 25063760 (24M) [application/x-gzip]
Saving to: ‘Gadus_morhua.gadMor3.0.115.gtf.gz’

Gadus_morhua.gadMor3.0.115.gtf 100%[====================================================>]  23.90M  41.4MB/s    in 0.6s

2025-10-03 13:26:04 (41.4 MB/s) - ‘Gadus_morhua.gadMor3.0.115.gtf.gz’ saved [25063760/25063760]
```

Organisation des fichiers attendue
```text plain
[samplesheet.csv] [sratoolkit.sh] [rnavar_pipeline.sh]

annotation/
[*.gtf]

fastq/
[*.fastq.gz]

genome/
[\<same as gtf>.fasta]
```

update FILE *sratoolkit.sh* to *load_data.sh*
```bash
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
```

test du script *load_data.sh*
```bash
sbatch load_data.sh
seff 25061279
-------------------------------------------------
Job ID: 25061279
Cluster: genobioinfo
User/Group: fmt101/formation
State: COMPLETED (exit code 0)
Cores: 1
CPU Utilized: 01:33:55
CPU Efficiency: 90.42% of 01:43:52 core-walltime
Job Wall-clock time: 01:43:52
Memory Utilized: 31.10 MB
Memory Efficiency: 1.52% of 2.00 GB
```

## Création du fichier samplesheet.csv

```bash
nano samplesheet.csv
```
```csv
sample,fastq_1,fastq_2,strandedness
TESTONE,/home/fmt101/work/Project/fasta/SRR2045415_1.fastq.gz,/home/fmt101/work/Project/fasta/SRR2045415_2.fastq.gz,unstranded
TESTTWO,/home/fmt101/work/Project/fasta/SRR2045416_1.fastq.gz,/home/fmt101/work/Project/fasta/SRR2045416_2.fastq.gz,unstranded
TESTTHREE,/home/fmt101/work/Project/fasta/SRR2045417_1.fastq.gz,/home/fmt101/work/Project/fasta/SRR2045417_2.fastq.gz,unstranded
```

## Création de la pipeline rnavar

```bash
nano pipeline_rnavar.sh
```
```bash
#!/bin/bash
#SBATCH -J nfcorernaseq
#SBATCH -p unlimitq
#SBATCH --mem=6G

module load bioinfo/Nextflow/25.04.0
module load devel/java/17.0.6

input=/home/fmt101/work/Project/samplesheet.csv
gtf=/home/fmt101/work/Project/annotation/Gadus_morhua.gadMor3.0.115.gtf

nextflow run nf-core/rnavar -profile genotoul -r 1.2.1 --input $input --outdir output/OUTDIR_rnavar --gtf $gtf --skip_baserecalibration
```

Plusieurs erreurs sont remontées :
```bash
WARN: The following invalid input values have been detected:

* --max_cpus: 48
* --max_memory: 120 GB
* --max_time: 4d
* --igenomesIgnore: true


WARN: Found the following unidentified headers in /home/fmt101/work/Project/samplesheet.csv:
        - strandedness

Known sites are required for performing base recalibration. Supply them with either --dbsnp and/or --known_indels or disable
 base recalibration with --skip_baserecalibration
```

```bash
WARN: The following invalid input values have been detected:

* --max_cpus: 48
* --max_memory: 120 GB
* --max_time: 4d
* --igenomesIgnore: true


WARN: Found the following unidentified headers in /home/fmt101/work/Project/samplesheet.csv:
        - strandedness

Missing `fromPath` parameter -- Check script '/home/fmt101/.nextflow/assets/nf-core/rnavar/subworkflows/local/prepare_genome
/main.nf' at line: 53 or see '.nextflow.log' file for more details
[-        ] NFC…REPARE_GENOME:GUNZIP_FASTA -
```

Récupération du dossier sur mon espace de travail personnel :
```bash
scp -r fmt101@genobioinfo.toulouse.inrae.fr:/home/fmt101/work/Project /home/simetra
```