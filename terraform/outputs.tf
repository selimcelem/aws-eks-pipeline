output "vpc_id" {
  description = "ID of the VPC hosting the EKS cluster."
  value       = aws_vpc.this.id
}

output "eks_cluster_name" {
  description = "Name of the EKS cluster."
  value       = aws_eks_cluster.this.name
}

output "ecr_repository_url" {
  description = "URL of the ECR repository for application images."
  value       = aws_ecr_repository.app.repository_url
}
