## Setup open telemetry using helm

helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts
helm repo update

auth token needs to be base 64 encoded use below and paste the value under collector-values.yaml file aganist nAuthorizatio field. 
echo -n '<user>:<password>' | openssl enc -base64

## Install
kubectl config set-context --current --namespace=open-telemetry-de-prod
helm install opentelemetry-collector open-telemetry/opentelemetry-collector -f ./collector-values.yaml -n open-telemetry-de-prod

## Update
kubectl config set-context --current --namespace=open-telemetry-de-prod
helm upgrade opentelemetry-collector open-telemetry/opentelemetry-collector -f ./collector-values.yaml

## Setup grafana-agent

Make sure kube-state-metrics is installed on the cluster, if not install using below. 
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts && helm repo update && helm install ksm prometheus-community/kube-state-metrics --set image.tag=v2.4.2 -n <namespace>
```
copy grafana_configmap.yaml to agent.yaml then run below which create configmap

```
kubectl create cm grafana-agent --from-file=agent.yaml -n grafana-de-uat 

```
Then just change the namespace under grafana_agent.yaml and run

```
kubectl apply --validate=true --dry-run=client --filename=grafana_agent.yaml -> to make sure there are no errors under the file

kubectl apply -f grafana_agent.yaml -n grafana-de-uat  -> creates statefulset,RBAC,service account and service.   

```
## Setup vector agent(to scrape metrics) and vector_log_agents (to scrape the logs) using helm chart

helm repo add vector https://helm.vector.dev && helm repo update

## Get the values file is required 

helm show values vector/vector > vectorvalues.yml

## Create a blank values file template if required

cat <<-'VALUES' > values.yaml
role: Agent
VALUES

### Installing log agent 

helm upgrade --install vector-logs vector/vector --namespace vector-de-uat -f logs.values.yaml --create-namespace

### Upgrading in place with no changes to values

helm upgrade --install vector-logs vector/vector --namespace vector-de-uat \
  --reuse-values

### Check data flow
```
kubectl -n vector exec -it daemonset/vector-logs-vector-logagent -- vector top \
        --url http://127.0.0.1:8686/graphql
```

## Agent

helm upgrade --install vector-agent vector/vector --namespace vector-de-uat -f agent.values.yaml

### Check data flow

```
kubectl -n vector exec -it deployment/vector-agent -- vector top --url http://127.0.0.1:8686/graphql
```
```
kubectl -n vector exec -it deployment/vector-agent -- vector tap
```
### Setup Node exporter to collect host related metrics (CPU, memory, network etc)
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts && helm repo update  
helm install node-exporter prometheus-community/prometheus-node-exporter -f values.yaml --namespace node-exporter-de-uat --create-namespace 
```
###
