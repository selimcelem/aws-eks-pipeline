![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazonwebservices&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Helm](https://img.shields.io/badge/Helm-0F1689?style=for-the-badge&logo=helm&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=githubactions&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-009639?style=for-the-badge&logo=nginx&logoColor=white)

# AWS EKS Application Deployment Pipeline

An end-to-end AWS infrastructure and CI/CD pipeline for deploying a containerized application to Kubernetes. The focus is the complete flow from code commit to a live, accessible API running on EKS — not the application itself.

> **Project type:** Cloud Portfolio Project
> **Source:** Industry-sourced mock project brief

---

## Business Context

A development team needs a scalable, production-grade environment to deploy containerized workloads on AWS. Infrastructure must be reproducible via code, deployments must be fully automated, and the application must be reachable over HTTP.

---

## Architecture Overview

```
GitHub (push to main)
    |
    v
GitHub Actions CI/CD
    |
    ├── Build Docker image
    ├── Push to Amazon ECR
    └── Deploy to EKS via Helm upgrade
            |
            v
      EKS Cluster (private subnets)
            |
            v
      Nginx Load Balancer (HTTP)
            |
            v
      Public endpoint (reachable from local machine)
```

---

## Stack

| Layer          | Technology                        |
|----------------|-----------------------------------|
| Cloud          | AWS (VPC, EKS, ECR, IAM, S3)     |
| IaC            | Terraform                         |
| Container      | Docker                            |
| Orchestration  | Kubernetes (Amazon EKS)           |
| Packaging      | Helm                              |
| CI/CD          | GitHub Actions                    |
| Load Balancer  | Nginx                             |

---

## Requirements

### Infrastructure (Terraform)

- VPC with 3 public and 3 private subnets
- NAT Gateway and routing tables
- EKS cluster with worker nodes in private subnets
- ECR repository for container images

### Application

- Simple REST API
- Containerized with a Dockerfile
- Source hosted on GitHub

### CI/CD (GitHub Actions)

- Triggered on push to `main`
- Builds Docker image
- Pushes image to Amazon ECR
- Deploys to EKS via `helm upgrade`
- AWS authentication via OIDC — no long-lived credentials stored in GitHub Secrets

### Helm

- Custom Helm chart
- Image version dynamically updated by the pipeline

### Networking

- Nginx load balancer
- HTTP access
- Reachable from local machine

### IAM (Bonus)

- IAM role attached to EKS nodes
- Pods can execute AWS SDK commands

---

## Project Structure

```
aws-eks-pipeline/
├── terraform/          # VPC, EKS, ECR, IAM infrastructure
├── app/                # REST API source code + Dockerfile
├── helm/               # Custom Helm chart
├── .github/workflows/  # CI/CD pipeline definitions
├── BUILD_LOG.md        # Development log
└── README.md
```

---

## Getting Started

### Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform >= 1.0
- Docker
- kubectl
- Helm 3
- GitHub account with Actions enabled

### Deploy Infrastructure

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### Build and Push Locally (optional)

```bash
docker build -t my-api ./app
docker tag my-api:latest <account-id>.dkr.ecr.<region>.amazonaws.com/my-api:latest
docker push <account-id>.dkr.ecr.<region>.amazonaws.com/my-api:latest
```

### Deploy with Helm

```bash
helm upgrade --install my-api ./helm \
  --set image.repository=<account-id>.dkr.ecr.<region>.amazonaws.com/my-api \
  --set image.tag=latest
```

---

## License

This project is for portfolio and educational purposes.
