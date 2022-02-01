#!/bin/bash

# export PREFIX="path to file"
export PREFIX="/home/bento/mtp-data-files/mtp-data-files/OT_21.06"

# export ES=localhost:9200
export ES=localhost:9200

# export INDEX_SETTINGS="path to index_settings.json"
export INDEX_SETTINGS="/home/bento/ppdc-dataloader/elasticsearch/index_settings.json"



echo ES = $ES

echo INDEX_SETTINGS = $INDEX_SETTINGS

echo PREFIX= $PREFIX