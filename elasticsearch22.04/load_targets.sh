#!/bin/bash

# curl -X DELETE "localhost:9200/target*?pretty" 
# green open target    61524 0 262.6mb 262.6mb
#cat "$1" | elasticsearch_loader --es-host "http://localhost:9200" --index-settings-file "index_settings.json" --bulk-size 5000 --index targets --type target --id-field id json --json-lines -
export INDEX_NAME="target"
export INPUT="${PREFIX}/targets_pmtl_v3"
export ID="id"

./load_jsons.sh
