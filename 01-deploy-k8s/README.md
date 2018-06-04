# Introduction
We will deploy a Kubernetes cluster in AWS using Kops, the command line tool from Kubernetes for deploying production-grade clusters. There are two configurations: 
* Development where the cluster will be located in a single availability zone, with one master and two nodes.
* Production where the cluster will be located in a three availability zones, with three master and siz nodes.

Once the cluster is operational, we will check its status using cubectl cli. 

# Setup
## Deploy development cluster

```bash
cd ~/infra-java-prevayler-K8S/01-deploy-k8s
./setup -t dev
```

Script will create S3 bucket to save kops state. Bucket name `--bucket ${CLUSTER_FULL_NAME}-state`, then deploy kubernetes using kops.
Kubernetes will have 2 worker nodes, and one master in us-east-1.

## Deploy production cluster

```bash
cd ~/infra-java-prevayler-K8S/01-deploy-k8s
./setup -t prod
```

```bash
kops create cluster \
     --name=${CLUSTER_FULL_NAME} \
     --master-zones=${!CLUSTER_AWS_AZ} \
     --zones=${!CLUSTER_AWS_AZ} \
     --master-size=${!CLUSTER_MASTER_AWS_EC2_SIZE} \
     --node-size=${!CLUSTER_NODE_AWS_EC2_SIZE} \
     --node-count=${!CLUSTER_NODE_COUNT} \
     --dns-zone=${!DOMAIN_NAME} \
     --kubernetes-version=${!CLUSTER_VERSION} \
     --ssh-public-key="~/.ssh/id_rsa.pub" \
     --yes
```

Script will create S3 bucket to save kops state. Bucket name `--bucket ${CLUSTER_FULL_NAME}-state`, then deploy kubernetes using kops.
Kubernetes will have 6 worker nodes, and three master in us-east-2, across three availability zones.

## Why to deploy development and production clusters in two different regions
Better to isolate development environment from production one, even better to use different AWS accounts. This will help:
* Limit resources per environment
* Control the billing per environment
* Different roles/permissions per environment


# Teardown
## teardown development cluster

```bash
cd ~/infra-java-prevayler-K8S/01-deploy-k8s
./teardown -t dev
```

## Teardown production cluster

```bash
cd ~/infra-java-prevayler-K8S/01-deploy-k8s
./teardown -t prod
```

Script will  delete all resources created during the setup step including the S3 bucket. ity zones.

## Why there is no dashboard or cluster auto-scaling deployed
Amazon already released EKS service as a Preview. Amazon Elastic Container Service for Kubernetes (Amazon EKS) is a managed service that
makes it easy for you to run Kubernetes on AWS without needing to install and operate your own Kubernetes clusters.

With Amazon EKS you get a highly-available, and secure Kubernetes control plane without needing to worry about provisioning, upgrades,
or patching. Amazon EKS is certified Kubernetes conformant so you can use all existing plugins and tooling from the Kubernetes
community. Any application running on any standard Kubernetes environment is fully compatible. 

I would go to use this managed service and it will requires less time to manage and maintain.


