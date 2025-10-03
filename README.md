# Projet RNA-seq Gadus morhua – Pipeline nf-core/rnavar

L'objectif de ce dépôt est de mettre à disposition l'ensemble des données et des étapes de l'analyse. Ceci afin de respecter le modèle FAIR mais aussi de pouvoir suivre les étapes de développement de la pipeline d'analyse.

## 🎯 Objectif du projet
Ce projet a pour but de déployer et tester le pipeline **[nf-core/rnavar](https://nf-co.re/rnavar)** sur des données RNA-seq de la morue de l’Atlantique (*Gadus morhua*), en utilisant le cluster **genobioinfo** et l’environnement **Nextflow**.

## 📂 Contenu du dépôt
- `load_data.sh` : script SLURM pour télécharger et convertir les données SRA en FASTQ.gz  
- `pipeline_rnavar.sh` : script SLURM pour lancer le pipeline nf-core/rnavar  
- `samplesheet.csv` : table des échantillons utilisée en entrée du pipeline  
- `Rapport.pdf` : rapport complet du projet (Introduction, Méthodes, Discussion, Conclusion)  

## 🧬 Données
Les jeux de données proviennent du **NCBI SRA** :  
- [SRR2045415](https://www.ncbi.nlm.nih.gov/sra/?term=SRR2045415) – tissu ovarien  
- [SRR2045416](https://www.ncbi.nlm.nih.gov/sra/?term=SRR2045416) – tissu cérébral  
- [SRR2045417](https://www.ncbi.nlm.nih.gov/sra/?term=SRR2045417) – échantillon complémentaire  

Les annotations et génomes de référence proviennent d’**Ensembl release 115** :  
- [GTF Gadus morhua gadMor3.0](https://ftp.ensembl.org/pub/release-115/gtf/gadus_morhua/Gadus_morhua.gadMor3.0.115.gtf.gz)  
- [FASTA gadMor3.0](https://ftp.ensembl.org/pub/release-115/fasta/gadus_morhua/dna/)  

## ⚙️ Environnement
Le projet a été exécuté sur le cluster **genobioinfo** avec :  
- `bioinfo/SRA-Toolkit/3.0.2`  
- `bioinfo/Nextflow/25.04.0`  
- `devel/java/17.0.6`  

## 🚧 Problématiques rencontrées
- Versions obsolètes de modules SRA Toolkit → solution : mise à jour vers `3.0.2`  
- Manque de permissions pour les liens symboliques → contourné par un téléchargement local  
- Fichier `samplesheet.csv` sensible au format → ajustement manuel nécessaire  
- Paramètres génome (`--genome`) non disponibles pour *Gadus morhua* → utilisation directe du fichier GTF/FASTA  

## 📜 Licence
Ce projet et donc l'ensemble des éléments de ce répertoire est sous [licence GPL-v3](https://github.com/CamilleAstrid/fr.utoulouse.BioSyst.NextFlow/blob/main/LICENSE) (sauf cas précisé).

Projet réalisé dans le cadre du Master Bioinformatique & Biologie des Systèmes, Université Toulouse III.  
Usage pédagogique uniquement.

## Auteurs
Le sujet a été fourni par Sarah Maman formatrice de l'unité d'enseignement.

<p/>

