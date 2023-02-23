#!/bin/bash
FOLDER_PREFIX="${PREFIX}/miss_evidence"
FOLDERS=$(ls -1 $FOLDER_PREFIX | grep 'sourceId')

for folder in $FOLDERS; do
  IFS='=' read -ra tokens <<< "$folder"

  token="evidence_datasource_${tokens[1]}"

  full_folder="${FOLDER_PREFIX}/${folder}/"

  export ID='id'
  export INDEX_NAME="${token}"
  export INPUT="${full_folder}"
  ./load_jsons.sh
done
