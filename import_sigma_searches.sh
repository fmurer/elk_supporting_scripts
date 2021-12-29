#!/bin/bash

TEMP_SIGMA_RULES="/tmp/sigma"
TEMP_SIGMA_SEARCHES="/tmp/searches"
SIGMA_URL="https://github.com/SigmaHQ/sigma"
KIBANA="http://localhost:5601"

############################
# Clone Current Sigma Rules
############################
echo "[+]  ----------------------------------------- Clone Current Sigma Rules -----------------------------------------"

git clone $SIGMA_URL $TEMP_SIGMA_RULES

echo "[+]  ----------------------------------------- Install SigmaTools -----------------------------------------"

############################
# Install SigmaTools
############################

python3 -m pip install sigmatools

echo "[+]  ----------------------------------------- Convert Windows Rules to Searches -----------------------------------------"

############################
# Convert Rules to searches
############################
mkdir -p $TEMP_SIGMA_SEARCHES

for s in $(find $TEMP_SIGMA_RULES/rules/windows/ -type f); do 
	name=$(basename -- $s); 
	sigmac --target kibana-ndjson --config $TEMP_SIGMA_RULES/tools/config/winlogbeat.yml $s > $TEMP_SIGMA_SEARCHES/$name.ndjson; 
	echo "[+]  Created - $s";
done

echo "[+]  ----------------------------------------- Import Searches to Kibana -----------------------------------------"

############################
# Import Searches
############################
for r in $(find $TEMP_SIGMA_SEARCHES -type f); do 
	curl -s -X POST -H "kbn-xsrf: true" $KIBANA/api/saved_objects/_import?overwrite=true --form file=@$r > /dev/null; 
	echo "[+]  Imported - $r"
done

echo "[+]  ----------------------------------------- Cleanup -----------------------------------------"

############################
# Cleanup
############################
rm -rf $TEMP_SIGMA_RULES
rm -rf $TEMP_SIGMA_SEARCHES