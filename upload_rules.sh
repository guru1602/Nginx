#!/bin/sh

URL="https://prometheus-prod-01-eu-west-0.grafana.net"
DEV_USER="950989"
PROD_USER="958855"
API_KEY="api-key"
in_path="./aggregations"

cd $in_path

#curl -XPUT -u "$TENANT:$KEY" "$URL/aggregations/rules" --data-binary "@amend_rules.json" -H "Content-type:application/json"


TMPFILE=$(mktemp)
trap 'rm "$TMPFILE"' EXIT
cat headers.txt | grep -i '^Etag:' | sed 's/^Etag:/If-Match:/i' > "$TMPFILE"
curl --request POST --header @"$TMPFILE" --data-binary @amend_rules.json -u "$DEV_USER:$API_KEY" "$URL/aggregations/rules"

# to run this script ./rules_upload.sh <your_new_rules_file.json>
