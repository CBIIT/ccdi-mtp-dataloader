# export PREFIX="path to file"
# export PREFIX="/Users/cheny39/Documents/dataFiles/0.1.0-0513/OT22.04"

#export PREFIX="/Users/cheny39/Documents/work/22.04/output"


export PREFIX="/Users/cheny39/Documents/work/22.09"


#export ES="https://search-mtp-openseach-gdbhnjpmzs37cklj3rd4zmybwy.us-east-1.es.amazonaws.com"
#cloudOne dev
export ES="https://vpc-mtp-opensearch-dev-akmgxd5o76x3at6t7conzlciam.us-east-1.es.amazonaws.com"
#export ES=localhost:9200
#export ES=https://vpc-mtp-opensearch-dev-akmgxd5o76x3at6t7conzlciam.us-east-1.es.amazonaws.com
#export ES=https://vpc-mtp-opensearch-qa-y4vflq7yz2zwwpwcxii6r75zza.us-east-1.es.amazonaws.com
# export INDEX_SETTINGS="path to index_settings.json"
export INDEX_SETTINGS="/Users/cheny39/Documents/work/mtp/ppdc-dataloader/elasticsearch22.04/index_settings.json"


# # where the ETL output prefix is located as inside it should find each step output
# export PREFIX=${ETL_PREFIX:-"out"}
# # empty prefix release. If you specify it it will be simply prefixed like "20.11_"...
# export RELEASE=${ETL_RELEASE:-""}
# # the default index settings file
# export INDEX_SETTINGS=${ETL_INDEX_SETTINGS:-"index_settings.json"}
# # default ES endpoint
# export ES=${ETL_ES:-"http://localhost:9200"}

# ./load_cancerbiomarker.sh
# ./load_diseases.sh
# ./load_disease_hpo.sh
# ./load_drugs.sh
# ./load_eco.sh
# ./load_evidences.sh
# ./load_evidences_aotf.sh
# ./load_expression.sh
# ./load_hpo.sh
# ./load_interaction.sh
# ./load_interaction_evidence.sh
# ./load_mp.sh
./load_openfda_faers.sh
# # #./load_otars.sh
# ./load_reactome.sh
./load_so.sh
# ./load_targets.sh
# ./load_go.sh
# echo "INDEX_SETTINGS different"
# ./load_known_drugs.sh
#./load_search.sh

# echo "INDEX_SETTINGS different"
# ./load_chop_nav_data.sh




# ./load_evidences_aotf.sh
# ./load_search.sh
# ./load_evidences.sh