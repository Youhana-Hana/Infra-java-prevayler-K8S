# Vagrant installation variables
export KUBECTL_VERSION="1.10.0"
export KOPS_VERSION="1.9.1"
export TERRAFORM_VERSION="0.11.7"

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
echo "source <(kubectl completion bash)" >>~/.profile
