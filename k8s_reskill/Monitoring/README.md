# Monitoring an EKS Cluster

## Configure Storage Class

```sh
kubectl create -f prometheus-storageclass.yaml
```

## Deploy Prometheus

```sh
helm install -f prometheus-values.yaml stable/prometheus --name prometheus --namespace prometheus
```

Check if Prometheus components deployed as expected

```sh
kubectl get all -n prometheus
```

You should see all the Prometheus pods, services, daemonsets, deployments, and replicasets are all ready and available.

You can access Prometheus server URL by going to any one of your Worker node IP address and specify port `:30900/targets` (for ex, `52.12.161.128:30900/targets`. Remember to open port 30900 in your Worker nodes Security Group. In the web UI, you can see all the targets and metrics being monitored by Prometheus

## Deploy Grafana

```sh
helm install -f grafana-values.yaml stable/grafana --name grafana --namespace grafana
```

Check if Grafana components are deployed as expected

```sh
kubectl get all -n grafana
```

You should see the Grafana po, service, deployment, and replicaset all ready and available.

You can get Grafana ELB URL using this command. Copy & Paste the value into browser to access Grafana web UI:

```
export ELB=$(kubectl get svc -n grafana grafana -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

echo "http://$ELB"
```

If Graphana not install properly:
kubectl create namespace grafana
helm install stable/grafana \
    --name grafana \
    --namespace grafana \
    --set persistence.storageClassName="gp2" \
    --set adminPassword="EKS!sAWSome" \
    --set datasources."datasources\.yaml".apiVersion=1 \
    --set datasources."datasources\.yaml".datasources[0].name=Prometheus \
    --set datasources."datasources\.yaml".datasources[0].type=prometheus \
    --set datasources."datasources\.yaml".datasources[0].url=http://prometheus-server.prometheus.svc.cluster.local \
    --set datasources."datasources\.yaml".datasources[0].access=proxy \
    --set datasources."datasources\.yaml".datasources[0].isDefault=true \
    --set service.type=LoadBalancer

Run the following command to check if Grafana is deployed properly:

kubectl get all -n grafana


export ELB=$(kubectl get svc -n grafana grafana -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

echo "http://$ELB"


When logging in, use the username admin and get the password hash by running the following:

kubectl get secret --namespace grafana grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

Create Dashboards
Login into Grafana dashboard using credentials supplied during configuration

You will notice that ‘Install Grafana’ & ‘create your first data source’ are already completed. We will import community created dashboard for this tutorial

Click ‘+’ button on left panel and select ‘Import’

Enter 3131 dashboard id under Grafana.com Dashboard & click ‘Load’.

Leave the defaults, select ‘Prometheus’ as the endpoint under prometheus data sources drop down, click ‘Import’.

This will show monitoring dashboard for all cluster nodes

For creating dashboard to monitor all pods, repeat same process as above and enter 3146 for dashboard id
