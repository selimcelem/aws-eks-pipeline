# AWS EKS Application Deployment Pipeline

## Overview

I built an end-to-end AWS infrastructure and CI/CD pipeline that takes a containerized application from a Git commit to a publicly reachable HTTP endpoint running on Amazon EKS. The focus of the project is the deployment pipeline and the cloud platform underneath it — not the application itself, which is deliberately a minimal Flask REST API used as a payload to exercise the full path.

## What I Built

- A reproducible AWS environment defined entirely in Terraform: a VPC with public and private subnets across three availability zones, an EKS cluster with a managed node group running on private subnets, an ECR repository for container images, and a set of IAM roles (cluster role, node role, and a separate S3 read-only role attachable to nodes so pods can call the AWS SDK).
- A small containerized Python REST API with a health endpoint, packaged with a Dockerfile, used as the workload that flows through the pipeline.
- A planned GitHub Actions pipeline that builds the Docker image, pushes it to ECR, and deploys to EKS via `helm upgrade` — authenticating to AWS through OIDC instead of long-lived credentials in GitHub Secrets.
- A custom Helm chart that exposes the service through an Nginx-backed load balancer so the API is reachable from outside the cluster.

## Technologies

- **Cloud:** AWS (VPC, EKS, ECR, IAM, S3)
- **Infrastructure as Code:** Terraform
- **Containers and Orchestration:** Docker, Kubernetes (Amazon EKS)
- **Packaging:** Helm
- **CI/CD:** GitHub Actions (with OIDC federation to AWS)
- **Networking:** Nginx load balancer
- **Application:** Python, Flask

## Problems Solved

- **Reproducible infrastructure.** Defining the network, cluster, registry, and IAM as Terraform code removed the click-ops risk and made the entire environment reviewable in pull requests and recreatable from scratch.
- **Secure cloud-to-CI authentication.** Wiring GitHub Actions to AWS through OIDC eliminated the need to store long-lived AWS access keys as repository secrets, which is the kind of credential that tends to leak and rarely gets rotated.
- **Clean separation of concerns at the network layer.** Running EKS worker nodes in private subnets, with a single NAT Gateway for egress and public subnets reserved for load balancers, keeps the workloads off the public internet by default while still allowing an HTTP endpoint to be exposed deliberately.
- **Pod-level AWS access without static credentials.** Designing a dedicated IAM role for S3 read-only access — rather than baking permissions into the node role wholesale — keeps the blast radius of pod credentials small and makes future permission changes auditable.

## What I Learned

- How to compose a production-shaped AWS network from primitives (VPC, subnets, IGW, NAT, route tables) instead of relying on a high-level module, which forced me to understand exactly what each piece does and why.
- The mechanics of EKS managed node groups: which IAM policies the cluster role versus the node role need, how subnet tagging drives load balancer placement, and how the control plane and data plane authenticate to each other.
- How OIDC federation between GitHub and AWS actually works end-to-end, and why it is the right default for any pipeline that touches a cloud account.
- The trade-offs of deploying with Helm from CI: dynamic image tags, idempotent upgrades, and keeping chart values out of secrets.
- Practical Terraform discipline — variables instead of hardcoded regions and account IDs, named outputs for downstream consumers, and tagging conventions that make resources traceable back to the project.
