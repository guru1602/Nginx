#!/bin/sh

prom_url="https://prometheus-prod-01-eu-west-0.grafana.net"
prom_user="958855"
api_key="api-key"
in_path="./aggregations"

mkdir -p $in_path
cd $in_path

#List recommendations
curl -u "$TENANT:$KEY" "$URL/aggregations/recommendations?verbose=true" > recommendation.json

# List current recommendations configuration
curl -u "$TENANT:$KEY" "$URL/aggregations/recommendations/config" > config.json

#Fetch the currently applied rules
curl -u "$TENANT:$KEY" -D headers.txt "$URL/aggregations/rules" > rules.json


# # Update recommendations configuration
# #curl -u "$TENANT:$KEY" --request POST --data @config.json "$URL/aggregations/recommendations/config"

# # List currently applied aggregation rules
# #curl -u "$TENANT:$KEY" "$URL/aggregations/rules"
