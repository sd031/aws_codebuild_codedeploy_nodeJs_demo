Steps:
Step 1:
Install AWS eksctl
Create AWS EKS Cluster
eksctl create cluster -f cluster_config/cluster.yaml

Step 2:
Create ECR Repository and
Push docker Image to AWS ECR

Step 3: 
kubectl apply -f deployment/deployment.yaml

kubectl apply -f deployment/service.yaml