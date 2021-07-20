
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
wget -nc -r ftp://ftp.ebi.ac.uk/pub/databases/opentargets/platform/21.06/output/literature/json/literatureIndex

wget -nc -r ftp://ftp.ebi.ac.uk/pub/databases/opentargets/platform/21.06/output/literature/json/vectors

wget -nc -r ftp://ftp.ebi.ac.uk/pub/databases/opentargets/platform/21.06/output/so/

wget -nc -r ftp://ftp.ebi.ac.uk/pub/databases/opentargets/platform/21.06/output/etl/json/
```
2. Download PPDC ETL data files

```text
git clone https://github.com/CBIIT/ppdc-data-pipeline.git
cd ppdc-data-pipeline
git checkout dev
```
data located in data/outputs

3. Create OT table **associations\_otf\_log**

```text
clickhouse-client --multiline --multiquery < aotf_log.sql
```

4. Import data

```text
cat part-00* | ./clickhouse-client -h localhost --query="insert into ot.associations_otf_log format JSONEachRow "
``` 

5. Create OT table **associations\_otf\_disease** and **associations\_otf\_target**

```text
clickhouse-client --multiline --multiquery < aotf.sql
``` 

Note -- associations\_otf\_disease and  associations\_otf\_target _read data from associations\_otf\_log

6. To load word2vec vectors from model

```text
clickhouse-client --multiline --multiquery < w2v_log.sql
gsutil -m cat gs://open-targets-data-releases/21.04/output/literature/vectors/part\* | clickhouse-client -h localhost --query="insert into ot.ml_w2v_log format JSONEachRow "
clickhouse-client --multiline --multiquery < w2v.sql
```
7.  To load literature
```text
clickhouse-client --multiline --multiquery < literature_log.sql
gsutil -m cat gs://open-targets-data-releases/21.04/output/literature/literatureIndex/part\* | clickhouse-client -h localhost --query="insert into ot.literature_log format JSONEachRow "
clickhouse-client --multiline --multiquery < literature.sql
```

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
TBD
```





