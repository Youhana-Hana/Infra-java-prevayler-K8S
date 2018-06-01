# Infra-java-prevayler-K8S
## Background / Problem
A development team has created a Java web app that is ready for a limited release (with reduced availability and reliability requirements). If the limited release is successful, the app will be rolled out for worldwide use. Once fully public, the application needs to be available 24/7 and must provide sub-second response times and continuity through single-server failures.

Create two environments - one for training and one for production. You should prepare the production environments for the limited release and plan for the scale out during fully public release.

Design and create the training and production environments, and provide a plan to scale out that deployment when the application goes public.

# Solution Roadmap
We need to create infrastructure that is flexible, automatic, consistent, reproducible, and disposable. We will use container solution, orchesterated though Kubernetes, deployed on AWS.

* Setup local develpment environment for DevOps. Follow [00-start-here/README.md/REAMDME](./00-start-here/README.md)
* Setup development environment. Follow [01-deploy-k8s/REAMDME](./01-deploy-k8s/README.md)
* Setup production environment. Follow [01-deploy-k8s/ REAMDME](./01-deploy-k8s/README.md)

# Principles applied
* Native cloud applications & Microservice architecture
* Infrastructure as Code and Microservices
* PhoenixServer
* One stack definition to manage infrastructure
* TDD & small batches
* The twelve-factor methodology

# Explanation of the decisions
Solution decided to use container to provide microservices solution. there are many concerns, when comes to microservices. For example, service discovery, auto-scaling, self healing, configurations, secrets, etc... This why Jubernentes is a good fit as most of these concerns managed by Kubernentes. Read more about [Kubernentes](!https://kubernetes.io/)

## Why not go to serverless?
Serverless is not a good fit for this java application as it's using Prevayler database to persist data, which write to desk to save its state. Another eason is to avlid vendor locking as Kubernentes runs in all cloud providers and available as a service.

# Links
* Infrastructure as Code and Microservices
* [PhoenixServer](!https://martinfowler.com/bliki/PhoenixServer.html)
* [Kubernetes labs](!https://kumorilabs.com/blog/k8s-0-introduction-blog-series-kubernetes/)
