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
Kubernetes will have 6 worker nodes, and three master in us-east-2, across thrree availability zones.

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
