output "vpc_id" {
  description = "ID of the VPC hosting the EKS cluster."
  value       = module.vpc.vpc_id
}

output "eks_cluster_name" {
  description = "Name of the EKS cluster."
  value       = module.eks.cluster_name
}

output "ecr_repository_url" {
  description = "URL of the ECR repository for application images."
  value       = module.ecr.repository_url
}
