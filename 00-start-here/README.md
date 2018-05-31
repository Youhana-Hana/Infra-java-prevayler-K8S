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

### Setup Kops Requirments
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
