#!/bin/bash

# export INDEX_SETTINGS="path to chop_nav.json"
export INDEX_SETTINGS="/Users/cheny39/Documents/work/OT/ppdc-dataloader/elasticsearch22.02/index_settings_chop_nav_data.json"



export INDEX_NAME="chop_data"
export INPUT="${PREFIX}/chop_data"
export ID="id"

./load_jsons.sh
