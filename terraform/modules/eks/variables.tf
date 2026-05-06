variable "project_name" {
  description = "Project name used for naming and tagging resources. Also used as the EKS cluster name."
  type        = string
}

variable "cluster_role_arn" {
  description = "ARN of the IAM role assumed by the EKS control plane."
  type        = string
}

variable "node_role_arn" {
  description = "ARN of the IAM role assumed by the EKS managed node group."
  type        = string
}

variable "public_subnet_ids" {
  description = "IDs of the public subnets the cluster's API endpoint will be associated with."
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "IDs of the private subnets where the managed node group runs."
  type        = list(string)
}
