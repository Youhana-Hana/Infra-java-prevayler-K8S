# Using Vagrant

There is a [Vagrantfile](./Vagrantfile) in the [00-start-here](.) folder of this repository, which will provision a Vagrant box that contains all the necessary tools needed to conduct the labs. You will need to have the following installed on your local host:

* [Vagrant](https://www.vagrantup.com/downloads.html)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads/)
* [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)


## Clone the Repository

```bash
git clone https://github.com/Youhana-Hana/Infra-java-prevayler-K8S.git 
cd 00-start-here
```

## AWS API Credentials

[Kops](https://github.com/kubernetes/kops#kubernetes-operations-kops), which we will be using to create Kubernetes clusters, requires you to have AWS API credentials configured. 

You can use your existing AWS user account or you can choose to create a dedicated user account for Kops.

### Setup Kops Requirements
Please refer to [kops requirments](https://github.com/kubernetes/kops/blob/master/docs/aws.md).

If you are using your existing AWS user account, you must have at a minimum the following [IAM policies attached](http://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_managed-using.html#policies_using-managed-console) to it (or you can use the `AdministratorAccess` policy which includes all of these permissions):

```console
AmazonEC2FullAccess
AmazonRoute53FullAccess
AmazonS3FullAccess
IAMFullAccess
AmazonVPCFullAccess
```

## Set the Required Environment Variables

You need to set the environment variables below with the AWS API credentials of the AWS user account you will be using:

```bash
export AWS_ACCESS_KEY_ID="AWS Access Key ID"
export AWS_SECRET_ACCESS_KEY="AWS Secret Access Key"
```

If you are not familiar with how to retrieve these values for your existing AWS user account, refer to the [AWS documentation](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-set-up.html).

## SSH Keys

Kops also requires a SSH public key file, which is used to create an AWS EC2 key pair for AWS instances that are created when creating a cluster.

Follow this [tutorial](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/#platform-linux) from GitHub on how to create one.

## Start the Vagrant Box

From the root of the repository:

```bash
cd 00-start-here
vagrant up
vagrant ssh
```

## Testing the Vagrant Box

ssh to the guest box and run the following commands:

```bash
kubectl version
kops version
aws help
```


## What we got
We got an ubuntu box, configured with all tools needed for the install Kubernetes using cops. We also exported both dev and prod configurations as environment variables


```bash
# export dev ENV variables to be used by provision script
echoToProfile "export dev_AWS_REGION=us-east-1" #US East (N. Virginia)
echoToProfile "export dev_AWS_AZ=us-east-1a" #availability zone
echoToProfile "export dev_CLUSTER_MASTER_SIZE=t2.micro"  #use t2 micro for the master node
echoToProfile "export dev_CLUSTER_NODE_SIZE=t2.nano"  #use t2.nano for the worker nodes
echoToProfile "export dev_CLUSTER_NODE_COUNT=2"  #number of worker nodes
echoToProfile "export dev_CLUSTER_VERSION=1.10.0"  #K8s version
echoToProfile "export dev_CLUSTER_DOMAIN_NAME=youhanalabs.com" #Domain name registered by AWS

# export production ENV variables to be used by provision script
echoToProfile "export prod_AWS_REGION=us-east-2" #US East (N. Virginia)
echoToProfile "export prod_AWS_AZ=us-east-2a,us-east-2b,us-east-2c" #availability zone
echoToProfile "export prod_CLUSTER_MASTER_SIZE=t2.medium" #use t2 medium for the master node
echoToProfile "export prod_CLUSTER_NODE_SIZE=t2.small" #use t2.small for the worker nodes
echoToProfile "export prod_CLUSTER_NODE_COUNT=6" #number of worker nodes
echoToProfile "export prod_CLUSTER_VERSION=1.10.0" #K8s version
echoToProfile "export prod_CLUSTER_DOMAIN_NAME=youhanalabs.com" #Domain name registered by AWS
```

## Next up
In the next step, We will deploy Kubernetes cluster using [seutp](../01-deploy-k8s/setup) script.


