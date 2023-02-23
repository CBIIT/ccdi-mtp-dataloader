#!/bin/bash

# export INDEX_SETTINGS="path to chop_nav.json"
export INDEX_SETTINGS="/Users/cheny39/Documents/work/mtp/ppdc-dataloader/elasticsearch22.04/index_settings_chop_nav_data.json"


export INDEX_NAME="chop_data"
export INPUT="${PREFIX}/chop_d2"

./load_jsons.sh
