# where the ETL output prefix is located as inside it should find each step output
export PREFIX=/Users/cheny39/Documents/work/22.11/json
# empty prefix release. If you specify it it will be simply prefixed like "20.11_"...
export INDEX_SETTINGS=/Users/cheny39/Documents/work/mtp/ppdc-dataloader/elasticsearch22.11/index_settings.json
# default ES endpoint
export ES=localhost:9200


./load_targets.sh
# ./load_diseases.sh
# ./load_disease_hpo.sh
# ./load_hpo.sh
# ./load_drugs.sh
# ./load_evidences.sh

# ./load_so.sh
# ./load_expression.sh
# ./load_mp.sh
# ./load_reactome.sh
# ./load_openfda_faers.sh
# ./load_otars.sh
# ./load_interaction.sh
# ./load_interaction_evidence.sh

# ./load_evidences_aotf.sh
# echo "INDEX_SETTINGS different"
# ./load_search.sh
# ./load_known_drugs.sh

# ./load_chop_nav_data.sh
