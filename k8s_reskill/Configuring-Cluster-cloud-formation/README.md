# 1.2 Configuring an EKS Cluster

- Create the EKS service role
- Create the VPC infrastructure using CloudFormation
- Create a cluster in the AWS Management Console
- Configure kubectl for EKS
- Configure aws-iam-authenticator
- Launch EKS worker nodes
- Deploy the Kubernetes dashboard

## Amazon EKS Prerequisites

Before you can create an Amazon EKS cluster, you must create an IAM role that Kubernetes can assume to create AWS resources. For example, when a load balancer is created, Kubernetes assumes the role to create an Elastic Load Balancing load balancer in your account. This only needs to be done one time and can be used for multiple EKS clusters.

You must also create a VPC and a security group for your cluster to use. Although the VPC and security groups can be used for multiple EKS clusters, we recommend that you use a separate VPC for each EKS cluster to provide better network isolation.

## Create EKS Service Role

### Create the EKS service role in the IAM console

1. Open the IAM console at [https://console\.aws\.amazon\.com/iam/](https://console.aws.amazon.com/iam/)\.

1. Choose **Roles**, then **Create role**\.

1. Choose **EKS** from the list of services, then **Allows Amazon EKS to manage your clusters on your behalf** for your use case, then **Next: Permissions**\.

1. Choose **Next: Review**\.

1. For **Role name**, enter a unique name for your role, such as `eksServiceRole`, then choose **Create role**\.

## Create EKS Cluster VPC

Specify this S3 template URL in CloudFormation:

`https://amazon-eks.s3-us-west-2.amazonaws.com/cloudformation/2018-11-07/amazon-eks-vpc-sample.yaml`

This is also available from the [EKS Getting Started Guide](https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html#vpc-create)

Note the `SecurityGroups`, `VpcId`, and `SubnetIds` output values.

## Create EKS Cluster

Use AWS Management Console, supplying values from the CloudFormation output in the previous step.

The Security group should be the one containing `ControlPlaneSecurityGroup` in the name.

**Note:** Be sure to create the EKS Cluster using the same IAM user or role that you intend to manage that cluster with from the CLI.

This step can take several minutes to complete.

## Install kubectl

For example, to install version 1.10.3 on macOS:

```sh
curl -o kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/darwin/amd64/kubectl

chmod +x ./kubectl
```

Ensure that `kubectl` is in your `PATH`.

To install on Amazon Linux:

```bash
curl -o kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/kubectl

chmod +x ./kubectl


mkdir $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH

echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
```

## Install aws-iam-authenticator

For example, to install version 1.10.3 for macOS:

```sh
curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/darwin/amd64/aws-iam-authenticator

chmod +x ./aws-iam-authenticator
```

Ensure that `aws-iam-authenticator` is in your `PATH`.

## Configure kubectl

`aws eks update-kubeconfig --name <cluster name>`

## Launch Worker Nodes

Wait for the cluster status to show `ACTIVE`.

Create the following CloudFormation stack using this S3 URL:

`https://amazon-eks.s3-us-west-2.amazonaws.com/cloudformation/2018-11-07/amazon-eks-nodegroup.yaml`

Specify the Amazon EKS-optimized AMI ID for your region:

|Region|Amazon EKS-optimized AMI|
|------|------------------------|
|US West (Oregon) (us-west-2)|ami-0f54a2f7d2e9c88b3|
|US East (N. Virginia)(us-east-1)|ami-0a0b913ef3249b655|
|US East (Ohio)(us-east-2)|ami-0958a76db2d150238|
|EU (Ireland)(eu-west-1)|ami-00c3b2d35bddd4f5c|

## Enable Worker Nodes to Join Cluster

Download the configuration map:

`curl -O https://amazon-eks.s3-us-west-2.amazonaws.com/cloudformation/2018-11-07/aws-auth-cm.yaml`

Edit this file, replacing the `<ARN of instance role (not instance profile)> ` snippet with the `NodeInstanceRole` value that you recorded in the previous procedure, and save the file.

Apply the configuration.

`kubectl apply -f aws-auth-cm.yaml`

`kubectl get nodes --watch`

## Deploy the Kubernetes Dashboard

`kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml`

`kubectl proxy &`

Browse to: <http://localhost:8080/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/>

## Get an authentication token

`aws-iam-authenticator token -i <cluster_name> --token-only`

Set this token in the k8s dashboard.
