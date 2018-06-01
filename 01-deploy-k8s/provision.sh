#!/bin/bash

# Exit on first failure and treat unset variables as error
set -eu

# check environment variable is set
function checkEnv {
    if [ -z ${1+x} ]; then
        echo "$1 is unset";
        exit 1;
    fi
}

# check AWS credentials exported
checkEnv "AWS_ACCESS_KEY_ID"
checkEnv "AWS_SECRET_ACCESS_KEY"

# Cluster alias default to dev
export CLUSTER_ALIAS="dev"

while getopts t: option
do
    case "${option}"
    in
        t) CLUSTER_ALIAS=${OPTARG};;
    esac
done

if [[ "${CLUSTER_ALIAS}" =~ ^(dev|prod)$ ]]; then
    echo "Target evnironment must be dev or prod";
    exit 1;
fi

# Domain name that is hosted in AWS Route 53
export DOMAIN_NAME="${CLUSTER_ALIAS}_CLUSTER_DOMAIN_NAME";

# Cluster Full DNS name
export CLUSTER_FULL_NAME="${CLUSTER_ALIAS}.${DOMAIN_NAME}"

# AWS availability zone where the cluster will be created
export CLUSTER_AWS_AZ="${CLUSTER_ALIAS}_AWS_AZ"

export CLUSTER_FULL_NAME="${CLUSTER_ALIAS}.${DOMAIN_NAME}"

export CLUSTER_MASTER_AWS_EC2_SIZE="${CLUSTER_ALIAS}_CLUSTER_MASTER_SIZE"
export CLUSTER_NODE_AWS_EC2_SIZE="${CLUSTER_ALIAS}_CLUSTER_NODE_SIZE"
export CLUSTER_NODE_COUNT="${CLUSTER_ALIAS}_CLUSTER_NODE_COUNT"
export K8S_VERSION="${CLUSTER_ALIAS}_CLUSTER_VERSION"

# Create a S3 bucket directly in AWS, which Kops will use to store all of the cluster configuration information:
aws s3api create-bucket --bucket ${CLUSTER_FULL_NAME}-state

# Export S3 URL
export KOPS_STATE_STORE="s3://${CLUSTER_FULL_NAME}-state"
echo "export KOPS_STATE_STORE=s3://${CLUSTER_FULL_NAME}-state" >>~/.profile #kops s3 bucket state

kops create cluster \
     --name=${CLUSTER_FULL_NAME} \
     --master-zones=${CLUSTER_AWS_AZ} \
     --zones=${CLUSTER_AWS_AZ} \
     --master-size=${CLUSTER_MASTER_AWS_EC2_SIZE} \
     --node-size=${CLUSTER_NODE_AWS_EC2_SIZE} \
     --node-count=${CLUSTER_NODE_COUNT} \
     --dns-zone=${DOMAIN_NAME} \
     --kubernetes-version=${K8S_VERSION} \
     --ssh-public-key="~/.ssh/id_rsa.pub" \
     --yes
#Create a cluster context alias in your kubeconfig file
kubectl config set-context ${CLUSTER_ALIAS} --cluster=${CLUSTER_FULL_NAME} --user=${CLUSTER_FULL_NAME}

#Use this new cluster context
kubectl config use-context ${CLUSTER_ALIAS}

# Smoke test, get cluster nodes
kubectl get nodes
