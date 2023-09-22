from datetime import datetime
from elasticsearch import Elasticsearch, RequestsHttpConnection
from requests_aws4auth import *

host = 'vpc-ivendi-prod-retailes-es-qdlimukjpamzfay462ys6t4nvi.eu-central-1.es.amazonaws.com' # For example, my-test-domain.us-east-1.es.amazonaws.com
region = 'eu-central-1' # e.g. us-west-1

service = 'es'

credentials = {
    'access_key': 'AKIAVQYKF4NGM4ORASWM',
    'secret_key': 'gydQJAqByQPVcB/scbj2THlBVASLVAqpS8yNkUWZ'
}

awsauth = AWS4Auth(credentials['access_key'], credentials['secret_key'], region, service)

es = Elasticsearch(
    hosts=[{'host': host, 'port': 443}],
    http_auth=awsauth,
    use_ssl=True,
    verify_certs=True,
    connection_class=RequestsHttpConnection
)

print(es.info())
