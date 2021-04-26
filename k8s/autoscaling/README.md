# Autoscaling an EKS Cluster

## Horizontal Pod Autoscaler (HPA)

### Install Helm

```bash
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh

chmod +x get_helm.sh

./get_helm.sh
```

### Configure Tiller RBAC

`kubectl apply -f tiller-rbac.yaml`

### Install Helm using Tiller Service Account

`helm init --service-account tiller`

### Install Metrics Server

```bash
helm install stable/metrics-server --name metrics-server --version 2.0.4 --namespace metrics`

kubectl get apiservice v1beta1.metrics.k8s.io -o yaml
```

### Deploy Apache/PHP

`kubectl run php-apache --image=k8s.gcr.io/hpa-example --requests=cpu=200m --expose --port=80`

### Autoscale the Deployment

`kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10`

### Check Status

`kubectl get hpa`

### Run Load Test

In a new terminal session:

```bash
kubectl run -i --tty load-generator --image=busybox /bin/sh
while true; do wget -q -O - http://php-apache; done
```

In another terminal:

`kubectl get hpa -w`

## Cluster Autoscaler

Find autoscaling group using the AWS Management Console, noting its name.

Edit the ASG's min/max size to 2 and 8 nodes, respectively.

Edit `cluster_autoscaler.yaml`, replacing `<AUTOSCALING GROUP NAME>` with the ASG name you found in the console.

Optionally change the `AWS_REGION` to something other than `us-east-1` if you are working in a different region.

Deploy the autoscaler:

`kubectl apply -f cluster_autoscaler.yaml`

Watch the logs:

`kubectl logs -f deployment/cluster-autoscaler -n kube-system`

Scale out:

```bash
kubectl apply -f nginx.yaml
kubectl get deployment/nginx-scaleout
kubectl scale --replicas=10 deployment/nginx-scaleout
```

## Cleaning Up

Delete the cluster autoscaler and nginx deployments:

```bash
kubectl delete -f cluster_autoscaler.yaml
kubectl delete -f nginx.yaml
```

Delete the horizontal pod autoscaler and load test

```bash
kubectl delete hpa,svc php-apache
kubectl delete deployment php-apache load-generator
```

kubectl delete -f deplyment.yaml
