# Vagrant installation variables
export KUBECTL_VERSION="1.10.0"
export KOPS_VERSION="1.9.1"
export TERRAFORM_VERSION="0.11.7"

function echoToProfile {
    profile_file="$HOME/.profile"
    if ! grep -q "$1" "${profile_file}" ; then
        echo "$1" >> "${profile_file}"
    fi
}

# Change to Vagrant home directory
cd /home/vagrant

# Install git, jq & unzip
sudo apt-get install git -y
sudo apt-get install jq -y
sudo apt-get install unzip -y

# Install AWS CLI (latest)
curl -s https://s3.amazonaws.com/aws-cli/awscli-bundle.zip -o awscli-bundle.zip
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
rm -rf awscli-bundle/ awscli-bundle.zip

# Install Docker (latest)
sudo curl -sSL https://get.docker.com/ | sh
sudo usermod -aG docker vagrant

# Install Terraform (version specified in Vagrant installation variables above)
wget --quiet https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
sudo chmod +x terraform
sudo mv terraform /usr/local/bin/terraform
rm -rf terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Install Kubectl (version specified in Vagrant installation variables above)
wget --quiet https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl
sudo chmod +x kubectl
sudo mv kubectl /usr/local/bin/kubectl

# Install Kops (version specified in Vagrant installation variables above)
wget --quiet https://github.com/kubernetes/kops/releases/download/${KOPS_VERSION}/kops-linux-amd64
sudo chmod +x kops-linux-amd64
sudo mv kops-linux-amd64 /usr/local/bin/kops

# Setup autocomplete for Kubectl
echoToProfile "source <(kubectl completion bash)"
# echo "source <(kubectl completion bash)" >>~/.profile

# export dev ENV variables to be used by provision script
echoToProfile "export dev_AWS_REGION=us-east-1" #US East (N. Virginia)
echoToProfile "export dev_AWS_AZ=us-east-1a" #availability zone
echoToProfile "export dev_CLUSTER_MASTER_SIZE=t2.micro"  #use t2 micro for the master node
echoToProfile "export dev_CLUSTER_NODE_SIZE=t2.nano"  #use t2.nano for the worker nodes
echoToProfile "export dev_CLUSTER_NODE_COUNT=2"  #number of worker nodes
echoToProfile "export dev_CLUSTER_VERSION=1.10.0"  #K8s version
echoToProfile "export dev_CLUSTER_DOMAIN_NAME=youhanalabs.com" #Domain name registered by AWS

# export production ENV variables to be used by provision script
echoToProfile "export prod_AWS_REGION=us-east-1" #US East (N. Virginia)
echoToProfile "export prod_AWS_AZ=us-east-1a,us-east-1b,us-east-1d" #availability zone
echoToProfile "export prod_CLUSTER_MASTER_SIZE=t2.medium" #use t2 medium for the master node
echoToProfile "export prod_CLUSTER_NODE_SIZE=t2.small" #use t2.small for the worker nodes
echoToProfile "export prod_CLUSTER_NODE_COUNT=6" #number of worker nodes
echoToProfile "export prod_CLUSTER_VERSION=1.10.0" #K8s version
echoToProfile "export prod_CLUSTER_DOMAIN_NAME=youhanalabs.com" #Domain name registered by AWS

# Compile ~/.profile to be ready for the same shell
source ~/.profile

# clone repo
git clone https://github.com/Youhana-Hana/Infra-java-prevayler-K8S.git ~/infra-java-prevayler-K8S
