#!/bin/bash
export INDEX_SETTINGS="/Users/cheny39/Documents/work/OT/ppdc-dataloader/elasticsearch22.02/index_settings_search_known_drugs.json"
export INDEX_NAME="known_drugs"
export INPUT="${PREFIX}/knownDrugsAggregated"

bash ./load_jsons.sh
