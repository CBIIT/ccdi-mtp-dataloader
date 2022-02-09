#!/bin/bash

# export INDEX_SETTINGS="path to index_settings.json"
export INDEX_SETTINGS=""



export INDEX_NAME="chop_data"
export INPUT="${PREFIX}/chop_data"
export ID="id"

./load_jsons.sh
