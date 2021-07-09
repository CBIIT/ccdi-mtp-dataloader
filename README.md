
## PPDC-dataloader

This repository contains scripts for data loading, the scripts are fork from  [platform-etl-backend](https://github.com/opentargets/platform-etl-backend) and modified by the PPDC Dev team. 

### Folder Structure

```text
-- clickhosue   # script to create database in clickhouse 
-- elasticsearch  # script to load data into es

```

### Env requirement

Recommend ES version 7.9.0

Python 3.7  and module elasticsearch\_loader

```text
Pip3 install elasticsearch_loader
```

### Data loader

#### Import data to clickhouse

1. Download data from S3 or FTP, takes 3 hours. 

```text
wget -r ftp://ftp.ebi.ac.uk/pub/databases/opentargets/platform/21.06/output/literature/

wget -r ftp://ftp.ebi.ac.uk/pub/databases/opentargets/platform/21.06/output/so/

wget -r ftp://ftp.ebi.ac.uk/pub/databases/opentargets/platform/21.06/output/etl/json/
```
2. Download PPDC ETL data files

```text
git clone https://github.com/CBIIT/ppdc-data-pipeline.git
cd ppdc-data-pipeline
git checkout dev
```
data located in data/outputs

3. Create OT table **associations\_otf\_log**
4. Import data
5. Create OT table **associations\_otf\_disease** and **associations\_otf\_target**

   Note -- associations\_otf\_disease and  associations\_otf\_target _read data from_ 

   associations\_otf\_log

####  Clickhouse data validation

 Check number of records in the tables

**ot.associations\_otf log** :    27297042 records

```text
select count(*) from ot.associations_otf_log
```

ot.**associations\_otf target:** 13648521 records

```text
select count(*) from ot.associations_otf_target
```

ot.**associations\_otf disease:** 13648521records

```text
select count(*) from ot.associations_otf_disease
```

#### Import data to ES

1. Download data from S3 or FTP
2. Update env.sh settings

```text
export PREFIX="path to data file"
export ES=localhost:9200
export INDEX_SETTINGS="path to index_settings.json"
```

   3. run ./load\_all.sh

#### ES data validatiaon 

Check the number of indices and the number of docs under each index.

Use the code to get the list of indices details

```text
curl http://localhost:9200/_cat/indices
```

```text
green open mouse_phenotypes                       _TavakhQToaIHPs0VBzyBw 5 0    60607  0  39.2mb  39.2mb
green open cancerbiomarker                        ZCgsFXLaT--2IrC12KzDIw 5 0     1613  0 823.9kb 823.9kb
green open search_drug                            agcgU17bSbiWrS2d4V7ZQQ 5 0    13076  0 136.2mb 136.2mb
green open .kibana-event-log-7.9.0-000001         LxJH_Ch1TNqBJyzGCPhNUQ 1 0        1  0   5.5kb   5.5kb
green open evidence_datasource_phewas_catalog     CR0jIIQZQCyvpkLPwkXh7w 5 0   182800  0 111.7mb 111.7mb
green open evidences_aotf                         SPeSeuISRr6BPZvEl26iuQ 5 0 76184416  0   5.5gb   5.5gb
green open evidence_datasource_intogen            C2qbpZXHQ1arXOa24dKoMw 5 0     3292  0   2.8mb   2.8mb
green open drug                                   qUNvbk15Q-GhK44pTC_YRA 5 0    13076  0  10.3mb  10.3mb
green open eco                                    avj49oUaTBK0YhJa7ZKprQ 5 0     4023  0   4.2mb   4.2mb
green open evidence_datasource_eva                rOcIy-T9QcG0U8hhwj8xLA 5 0   837193  0 584.3mb 584.3mb
green open evidence_datasource_sysbio             2jml-SbRTD-9bYWk3ch7CQ 5 0      423  0   994kb   994kb
green open evidence_datasource_chembl             o7hlw6grStqvKKiW5UiUWQ 5 0   521846  0 288.9mb 288.9mb
green open evidence_datasource_uniprot_literature YEU48HjwTyyCDf0rF9nWnw 5 0     5306  0   5.1mb   5.1mb
green open .apm-custom-link                       e9OEL0RlSzy26dhTraXz0w 1 0        0  0    208b    208b
green open evidence_datasource_eva_somatic        62dCPv-BTeSp-hqgQ80fcg 5 0    11187  0   7.5mb   7.5mb
green open mechanism_of_action                    mTx44MHeSx2_gGvD7P2Htg 5 0     5013  0     3mb     3mb
green open .kibana_task_manager_1                 WXWdqALlSFml6eVg0ylpOw 1 0        6 78  32.3kb  32.3kb
green open evidence_datasource_clingen            Fg7olWphR8iWq2SXRoaStw 5 0     1293  0   1.6mb   1.6mb
green open disease_hpo                            OtRoLQBQQDGHqD65yJdAkg 5 0   165412  0  48.6mb  48.6mb
green open interaction_evidence                   zny8OrDtRFeDhuVnvguw_Q 5 0 23329036  0   3.2gb   3.2gb
green open evidence_datasource_cancer_gene_census yFU-wr9uQgKD0NGCHX-fvg 5 0    61666  0  33.7mb  33.7mb
green open so                                     Vg6oVwrbT6umeXPd5ugqPA 5 0     2423  0   1.6mb   1.6mb
green open evidence_datasource_expression_atlas   _w41pTrjRHGbLw04qdkdZw 5 0   225976  0 153.2mb 153.2mb
green open evidence_datasource_europepmc          VjJnt5PUSPWCIhiOWBGlww 5 0 10551086  0  13.9gb  13.9gb
green open reactome                               mViz1QZ1RzmnhkbF8QGCVQ 5 0     2516  0   1.7mb   1.7mb
green open expression                             E4fpYfkeReawiVmRDgEy5g 5 0    43782  0   376mb   376mb
green open disease                                lGrZJXVBRa-BqELGNQYc3w 5 0    18497  0  30.6mb  30.6mb
green open evidence_datasource_crispr             W-yeQTtTSZ-Zv1fDwlOc6Q 5 0     1846  0   1.7mb   1.7mb
green open search_target                          dGbrzGGyQi-i8m7Mab23DQ 5 0    60608  0   2.5gb   2.5gb
green open hpo                                    AUUPzNbDQWes07yPf7gRIw 5 0    25495  0  12.6mb  12.6mb
green open evidence_datasource_ot_genetics_portal f6AGe1AdQaeGN_XYoRoHQQ 5 0   388324  0 292.6mb 292.6mb
green open .apm-agent-configuration               fx0re0gqQxCQwqJOllaWZg 1 0        0  0    208b    208b
green open drug_warnings                          m3JZoF3rQN2CAoZ9Mpr-bQ 5 0     1256  0 924.9kb 924.9kb
green open evidence_datasource_gene2phenotype     zFlNYjAaRZu0-tAAZZsFqg 5 0     2550  0   2.5mb   2.5mb
green open known_drugs                            mqxkZua0T6SQZQStWXetow 5 0   224248  0  10.4gb  10.4gb
green open .kibana_1                              88yqcZhBRHGvAr4EomP5JA 1 0       24  0  10.4mb  10.4mb
green open evidence_datasource_progeny            -uu4lWQmS0eQOPWo592XTQ 5 0      420  0   551kb   551kb
green open evidence_datasource_slapenrich         r7-EQm4WR-6YcVG2M8M2Aw 5 0    78057  0  38.6mb  38.6mb
green open target                                 f4pLCdntQM6wyP40SbQBAA 5 0    60607  1  72.6mb  72.6mb
green open evidence_datasource_reactome           tu5DVWY4QNK844d1d3f7QQ 5 0     9718  0   8.4mb   8.4mb
green open evidence_datasource_genomics_england   43HaSqOzRduNnBdPTk8_FA 5 0    20687  0  21.7mb  21.7mb
green open evidence_datasource_uniprot_variants   QNNUmjLEQVKNACtMLO-9fg 5 0    33465  0  22.6mb  22.6mb
green open search_disease                         _Leonbp2QAmXs0gDnnq_bQ 5 0    18497  0   1.6gb   1.6gb
green open interaction                            vt5_qiPnSsu5hYlNlOC5Qw 5 0 12622590  0   1.3gb   1.3gb
green open evidence_datasource_phenodigm          VSgbQFRSTRCHFNBg2g3_Ag 5 0   711386  0     1gb     1gb
green open indication                             67NuVTmySYmC1o7VmhiEmA 5 0     7427  0   8.8mb   8.8mb
```





