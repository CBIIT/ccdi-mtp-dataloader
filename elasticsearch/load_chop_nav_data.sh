#!/bin/bash

export INDEX_SETTINGS="index_settings_chop_nav_data.json"

export INDEX_NAME="chop_data"
export INPUT="${PREFIX}/chop_data"
export ID="id"

./load_jsons.sh
