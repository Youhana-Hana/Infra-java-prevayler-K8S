#!/bin/bash

# Exit on first failure and treat unset variables as error
set -eu

# check AWS credentials exported
if [ -z ${AWS_ACCESS_KEY_ID+x} ]; then
    echo "AWS_ACCESS_KEY_ID is unset";
    exit 1;
fi

if [ -z ${AWS_SECRET_ACCESS_KEY+x} ]; then
    echo "AWS_SECRET_ACCESS_KEY is unset";
    exit 1;
fi

# Domain name that is hosted in AWS Route 53
export DOMAIN_NAME="youhanalabs.com"

# Cluster alias
export CLUSTER_ALIAS="dev"

# Cluster Full DNS name
export CLUSTER_FULL_NAME="${CLUSTER_ALIAS}.${DOMAIN_NAME}"

# AWS availability zone where the cluster will be created
export CLUSTER_AWS_AZ="us-east-1a"

export CLUSTER_FULL_NAME="${CLUSTER_ALIAS}.${DOMAIN_NAME}"

# Create a S3 bucket directly in AWS, which Kops will use to store all of the cluster configuration information:
aws s3api create-bucket --bucket ${CLUSTER_FULL_NAME}-state

# Export S3 URL
export KOPS_STATE_STORE="s3://${CLUSTER_FULL_NAME}-state"

kops create cluster \
     --name=${CLUSTER_FULL_NAME} \
     --zones=${CLUSTER_AWS_AZ} \
     --master-size="t2.micro" \
     --node-size="t2.nano" \
     --node-count="2" \
     --dns-zone=${DOMAIN_NAME} \
     --ssh-public-key="~/.ssh/id_rsa.pub" \
     --kubernetes-version="1.10.0"
