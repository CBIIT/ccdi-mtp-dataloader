
## PPDC-dataloader

This repository contains scripts for data loading, the scripts are fork from  [platform-etl-backend](https://github.com/opentargets/platform-etl-backend) and modified by the PPDC Dev team. 

### Folder Structure

```text
-- clickhosue   # script to create database in clickhouse 
-- elasticsearch  # script to load data into es

```

### Env requirement

Recommend ES version 7.9.0

Python 3.7 or 2.7  and module elasticsearch\_loader

```text
pip install elasticsearch_loader
```

### Data loader

#### Import data to clickhouse 

1. Download data from S3 or FTP, takes 8 hours. 

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
clickhouse client --multiline --multiquery < aotf_log.sql
```

4. Import data (10 minutes)

```text
cat /home/bento/21.06/AOTFClickhouse/part-00* | clickhouse client -h localhost --query="insert into ot.associations_otf_log format JSONEachRow "
``` 

5. Create OT table **associations\_otf\_disease** and **associations\_otf\_target**  (6 minutes)

```text
clickhouse client --multiline --multiquery < aotf.sql
``` 

Note -- associations\_otf\_disease and  associations\_otf\_target _read data from associations\_otf\_log

6. To load word2vec vectors from model

```text
clickhouse client --multiline --multiquery < w2v_log.sql
cat /home/bento/21.06//literature/vectors/part* | clickhouse-client -h localhost --query="insert into ot.ml_w2v_log format JSONEachRow "
clickhouse client --multiline --multiquery < w2v.sql
```
7.  To load literature (40 minutes)
```text
clickhouse client --multiline --multiquery < literature_log.sql
```

```text
cat /home/bento/21.06/literature/literatureIndex/part-00000-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00001-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00002-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00003-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00004-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00005-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00006-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00007-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00008-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00009-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00010-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00011-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00012-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00013-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00015-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00016-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00017-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00018-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00019-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00020-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00021-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00022-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00023-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00024-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00025-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00026-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00027-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00028-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00029-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00030-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00031-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00032-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00033-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00034-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00035-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00036-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00037-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00038-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00039-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00040-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00041-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00042-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00043-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00044-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00045-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00046-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00047-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00048-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00049-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00050-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00051-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00052-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00053-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00054-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00055-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00056-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00057-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00058-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00059-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00060-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00061-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00062-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00063-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00064-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00065-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00066-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00067-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00068-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00069-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00070-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00071-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00072-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00073-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00074-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00075-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00076-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00077-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00078-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00079-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00080-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00081-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00082-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00083-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00084-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00085-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00086-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00087-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00088-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00089-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00090-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00091-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00092-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00093-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00094-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00095-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00096-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00097-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00098-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00099-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00100-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00101-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00102-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00103-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00104-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00105-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00106-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00107-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00108-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00109-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00110-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00111-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00112-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00113-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00114-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00115-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00116-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00117-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00118-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00119-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00120-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00121-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00122-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00123-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00124-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00125-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00126-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00127-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00128-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00129-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00130-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00131-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00132-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00133-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00134-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00135-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00136-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00137-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00138-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00139-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00140-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00141-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00142-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00143-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00144-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00145-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00146-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00147-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00148-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00149-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00150-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00151-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00152-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00153-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00154-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00155-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00156-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00157-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00158-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00159-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00160-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00161-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00162-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00163-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00164-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00165-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00166-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00167-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00168-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00169-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00170-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00171-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00172-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00173-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00174-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00175-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00176-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00177-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00178-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00179-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00180-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00181-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00182-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00183-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00184-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00185-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00186-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00187-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00188-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00189-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00190-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00191-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00192-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00193-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00194-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00195-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00196-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00197-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00198-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
cat /home/bento/21.06/literature/literatureIndex/part-00199-5956251d-6136-4333-959d-72607d37135f-c000.json  | clickhouse client -h localhost --query="insert into ot.literature_log format JSONEachRow " 
```

Connect to clickhouse and create table through the script below. 

connect to clickhouse
```text
clickhouse client 
```

create table literature_index
```text
create table if not exists ot.literature_index \
    engine = MergeTree() \
        order by (keywordId, intHash64(pmid), year, month, day) \
    as ( \
        select pmid, pmcid, keywordId, relevance, date, year, month, day \
        from ot.literature_log \
        ); \
```

create table literature
```text
create table if not exists ot.literature
    engine = MergeTree()
        order by (intHash64(pmid))
as (
    select pmid,
           any(pmcid) as pmcid,
           any(date) as date,
           any(year) as year,
           any(month) as month,
           any(day) as day,
           any(sentences) as sentences
    from ot.literature_log
    group by pmid
);

```
####  Clickhouse data validation

 Check number of records in the tables

**ot.associations\_otf log** :    v1-27297042 -> v2-13267378 records

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
export PREFIX="/home/bento/21.06"
export ES=localhost:9200
export INDEX_SETTINGS="/home/bento/ppdc-dataloader/elasticsearch/index_settings.json"
```

   3. run ./load\_all.sh

#### ES data validatiaon 

Check the number of indices and the number of docs under each index.

Use the code to get the list of indices details

```text
curl http://localhost:9200/_cat/indices
```


```text
green open mouse_phenotypes                       HGrgV5DzT9iw6D4yvBwGyw 5 0    60605    0  40.5mb  40.5mb
green open cancerbiomarker                        HSFbVDC7TYG2lVqqIz0SrQ 5 0     1613    0     1mb     1mb
green open search_drug                            uutGZ4sDTrawNpTDz8yrQQ 5 0    13185    0 136.9mb 136.9mb
green open evidence_datasource_phewas_catalog     b7PkTazUQn-e6HwdtsHUSA 5 0   183064    0  96.2mb  96.2mb
green open evidences_aotf                         nZVI9TbgRRezaBCYbjxWBQ 5 0 72921523    0   5.3gb   5.3gb
green open evidence_datasource_intogen            v0oJ0sSQS6eYKyHnbV1k1w 5 0     3141    0     2mb     2mb
green open drug                                   Uo-s3DyHSIK0s4IX_mtG1A 5 0    13185    0  11.9mb  11.9mb
green open eco                                    usa_0HM4Qs2cr4l3aPJfZA 5 0     4098    0     5mb     5mb
green open evidence_datasource_eva                VD2OfbVLTvGBaq0vbK0RiQ 5 0   855569    0 582.8mb 582.8mb
green open evidence_datasource_chembl             gV3F4_rmTKG5SaOy1zlehg 5 0   529149    0   233mb   233mb
green open evidence_datasource_uniprot_literature RfpITL-oRju6DBrzH9YCPg 5 0     5322    0   3.7mb   3.7mb
green open evidence_datasource_sysbio             48q9kIQCQe2Fq5Yo-EGi1A 5 0      389    0 725.2kb 725.2kb
green open evidence_datasource_eva_somatic        ObiBpbEQQIKZVPkSbW3xBw 5 0    11589    0   8.3mb   8.3mb
green open mechanism_of_action                    GD25HBykRXSqy4uE118QZw 5 0     5013    0     4mb     4mb
green open evidence_datasource_clingen            -noxd_M3TK62Z1q6SXIKfA 5 0     1309    0   1.2mb   1.2mb
green open interaction_evidence                   hDbB9LpGSYef6PQYUpo_LQ 5 0 22525292    0     3gb     3gb
green open disease_hpo                            bMDR8MGeSO2Ly5DnaOc5dQ 5 0   165688    0  61.2mb  61.2mb
green open evidence_datasource_cancer_gene_census 1zo3p_dhRpite5VT9Z8PvA 5 0    63311    0  28.1mb  28.1mb
green open so                                     erXGqFN_QsGQ4Ew_J581AA 5 0     2423    0   1.7mb   1.7mb
green open evidence_datasource_expression_atlas   5LMpAa2DQkClsHwXMgal5g 5 0   225933    0 126.3mb 126.3mb
green open evidence_datasource_europepmc          hx2EksH9TI6fL_J3I11VOg 5 0  9916059    0  12.2gb  12.2gb
green open reactome                               KfJgkr0dRl6TQieNL4miLQ 5 0     2536    0   1.5mb   1.5mb
green open expression                             Zjt4dgZYS0i38yjznUWVrQ 5 0    43782    0 370.3mb 370.3mb
green open disease                                DYz4GZwLQNKa5p0mMEK-kg 5 0    18507    0  33.8mb  33.8mb
green open evidence_datasource_crispr             vPt8ij1cSgC6wGcfDyAVpw 5 0     1846    0   1.7mb   1.7mb
green open evidence_datasource_orphanet           VjyA0VLUQo63mFsKn96n2w 5 0     5736    0   3.8mb   3.8mb
green open search_target                          Ecq7osZ6SSe5irz171borQ 5 0    60606    0   2.1gb   2.1gb
green open hpo                                    _u8jNWiJSkeElMC30caR0g 5 0    25709    0  13.2mb  13.2mb
green open evidence_datasource_ot_genetics_portal ua8wWR04Q-ipw9_NcSvwig 5 0   608262    0 385.5mb 385.5mb
green open drug_warnings                          Spt2HlI4SpSoSn89FrXi_Q 5 0     1256    0 937.3kb 937.3kb
green open evidence_datasource_gene2phenotype     3QXPgH3xR8S1nqdz4rtBjQ 5 0     2506    0   1.7mb   1.7mb
green open known_drugs                            MQ9F4b7uS7iUoOLJh1Fs3w 5 0   227963    0   5.3gb   5.3gb
green open evidence_datasource_progeny            D6_aaCu6SiqpbEEFNIjWWA 5 0      378    0 559.7kb 559.7kb
green open evidence_datasource_slapenrich         9DTXvuEDReGngrST-H_myA 5 0    72369    0  30.8mb  30.8mb
green open target                                 VGJ0JDPYQQek5iNk2vWnmg 5 0    60608 3965  69.5mb  69.5mb
green open evidence_datasource_reactome           ld_O4S_RTK2RV4pMsjGEqQ 5 0     9673    0     8mb     8mb
green open evidence_datasource_genomics_england   InsIcPGMRcuTyMCZdCq-rQ 5 0    19322    0  18.4mb  18.4mb
green open evidence_datasource_uniprot_variants   dtbOpPPESb6EpsSZeFx7QA 5 0    34001    0  18.7mb  18.7mb
green open search_disease                         S9aifCbyRIeRcynq-iakvg 5 0    18507    0   1.1gb   1.1gb
green open interaction                            R6gQjD14S6-5mz9H9Y8w0A 5 0 12152852    0   1.2gb   1.2gb
green open evidence_datasource_phenodigm          pkaHnpJMQ8C9Q3R8yFi5CA 5 0   718250    0 838.6mb 838.6mb
green open indication                             FDLQHnbhSzCAVqj5mcN14Q 5 0     7672    0  11.9mb  11.9mb

```




