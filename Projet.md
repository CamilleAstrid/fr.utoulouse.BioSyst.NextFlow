# Nextflow

Initiation sur genobioinfo

| Mini projet noté |
|------------------|


## Sujet

Lancer le pipeline **Nextflow nf-core rnavar** sur des données NCBI.

Choisir deux échantillons ***Gadus m.*** sur le site du NCBI avec la réference fasta associées ; puis lancer le pipeline Nextflow sur ces jeux de données.

Je vous propose de choisir les échantillons Gadus_morhua : ***SRR2045415*** , ***SRR2045416***, ***SRR2045417***.

Expliquer votre démarches et les résultats obtenus.


Pour réaliser l'ensemble de ces exercices, vous avez besoin :

* De vous connecter au cluster de calculs en utilisant les login et mot de passe de votre compte «genobioinfo», que je vais vous transmis en cours.
* Attention, ces comptes de formation ne sont valables qu’un mois maximum. 
* Merci de me rendre vos exercices dans un seul document PDF, si possible en latex, envoyé par mail : sarah.maman@inrae.fr


## Résolution des problèmes

### Singularity error

---
<i>
Pour résoudre l'erreur liée à Singularity. Les pipelines Nextflow nf-core ont besoin, en plus des modules Nextflow et java, des modules nfcore pour fonctionner. Il est donc nécessaire de charger aussi un des modules ci-dessous (cf version pipeline):

```bash
# search_module nfcore
bioinfo/NextflowWorkflows/nfcore-Nextflow-v20.11.0-edge
bioinfo/NextflowWorkflows/nfcore-Nextflow-v21.10.6
bioinfo/NextflowWorkflows/nfcore-Nextflow-v22.12.0-edge
bioinfo/NextflowWorkflows/nfcore-Nextflow-v23.04.3
bioinfo/NextflowWorkflows/nfcore-Nextflow-v23.10.0
bioinfo/NextflowWorkflows/nfcore-Nextflow-v24.04.2
bioinfo/NextflowWorkflows/nfcore-Nextflow-v24.10.0
bioinfo/NextflowWorkflows/nfcore-Nextflow-v24.10.2
bioinfo/NextflowWorkflows/nfcore-Nextflow-v25.04.0
```
Ces modules fait pour nfcore chargent ce qui est utile pour nfcore:
```bash
# module show bioinfo/NextflowWorkflows/nfcore-Nextflow-v25.04.0
-------------------------------------------------------------------
/tools/modulefiles/bioinfo/NextflowWorkflows/nfcore-Nextflow-v25.04.0:

module-whatis   {loads the bioinfo/NextflowWorkflows/nfcore-Nextflow-v25.04.0 environment}
module          load devel/java/17.0.6
module          load containers/singularity/3.9.9
module          load bioinfo/Nextflow/25.04.0
module          load devel/python/Python-3.11.1
setenv          NXF_SINGULARITY_CACHEDIR /usr/local/bioinfo/src/NextflowWorkflows/singularity-img/
-------------------------------------------------------------------
```

Je vous laisse ajouter cette ligne dans vos fichiers batch.
</i>

Puisque les pipelines sont lancés sur genotoul, je vous conseille de regarder le fichier batch test mis à disposition sur https://bioinfo.genotoul.fr/ et veiller à préciser le profile genotoul.

---