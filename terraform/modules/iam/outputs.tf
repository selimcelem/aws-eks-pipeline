output "eks_cluster_role_arn" {
  description = "ARN of the IAM role assumed by the EKS control plane."
  value       = aws_iam_role.eks_cluster.arn
}

output "eks_cluster_role_name" {
  description = "Name of the IAM role assumed by the EKS control plane."
  value       = aws_iam_role.eks_cluster.name
}

output "eks_node_role_arn" {
  description = "ARN of the IAM role assumed by the EKS managed node group."
  value       = aws_iam_role.eks_nodes.arn
}

output "eks_node_role_name" {
  description = "Name of the IAM role assumed by the EKS managed node group."
  value       = aws_iam_role.eks_nodes.name
}

output "s3_readonly_role_arn" {
  description = "ARN of the standalone S3 read-only role attachable to nodes."
  value       = aws_iam_role.s3_readonly.arn
}

output "s3_readonly_role_name" {
  description = "Name of the standalone S3 read-only role attachable to nodes."
  value       = aws_iam_role.s3_readonly.name
}
