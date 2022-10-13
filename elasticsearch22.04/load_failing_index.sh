#!/bin/bash

# red   open search_target   
# red   open evidence_datasource_chop_variant_level_snv                          
# red   open evidence_datasource_intogen                
# red   open evidence_datasource_chop_gene_level_snv    
# red   open evidence_datasource_gene2phenotype         
# red   open evidence_datasource_reactome     


curl -X DELETE 'https://vpc-mtp-opensearch-dev-akmgxd5o76x3at6t7conzlciam.us-east-1.es.amazonaws.com/evidence_datasource_chop_variant_level_snv?pretty'          

curl -X DELETE 'https://vpc-mtp-opensearch-dev-akmgxd5o76x3at6t7conzlciam.us-east-1.es.amazonaws.com/evidence_datasource_intogen?pretty'          

curl -X DELETE 'https://vpc-mtp-opensearch-dev-akmgxd5o76x3at6t7conzlciam.us-east-1.es.amazonaws.com/evidence_datasource_chop_gene_level_snv?pretty'          

curl -X DELETE 'https://vpc-mtp-opensearch-dev-akmgxd5o76x3at6t7conzlciam.us-east-1.es.amazonaws.com/evidence_datasource_gene2phenotype?pretty'          

curl -X DELETE 'https://vpc-mtp-opensearch-dev-akmgxd5o76x3at6t7conzlciam.us-east-1.es.amazonaws.com/evidence_datasource_reactome?pretty'          

curl -X DELETE 'https://vpc-mtp-opensearch-dev-akmgxd5o76x3at6t7conzlciam.us-east-1.es.amazonaws.com/search_target?pretty'          




export ID='id'
export INDEX_NAME="evidence_datasource_chop_variant_level_snv"
export INPUT="/Users/cheny39/Documents/dataFiles/22.04/evidence/sourceId=chop_variant_level_snv 
"
  ./load_jsons.sh



export ID='id'
export INDEX_NAME="evidence_datasource_intogen"
export INPUT="/Users/cheny39/Documents/dataFiles/22.04/evidence/sourceId=intogen 
"
  ./load_jsons.sh




export ID='id'
export INDEX_NAME="evidence_datasource_chop_gene_level_snv"
export INPUT="/Users/cheny39/Documents/dataFiles/22.04/evidence/sourceId=chop_gene_level_snv 
"
  ./load_jsons.sh



export ID='id'
export INDEX_NAME="evidence_datasource_gene2phenotype"
export INPUT="/Users/cheny39/Documents/dataFiles/22.04/evidence/sourceId=gene2phenotype 
"
  ./load_jsons.sh



export ID='id'
export INDEX_NAME="evidence_datasource_reactome"
export INPUT="/Users/cheny39/Documents/dataFiles/22.04/evidence/sourceId=reactome 
"
  ./load_jsons.sh


# export INDEX_SETTINGS="index_settings_search.json"

# export INDEX_NAME="search_target"
# export INPUT="${PREFIX}/searchTarget"
# ./load_jsons.sh
