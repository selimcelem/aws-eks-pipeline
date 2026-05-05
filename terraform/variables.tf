variable "aws_region" {
  description = "AWS region to deploy resources into."
  type        = string
  default     = "eu-west-1"
}

variable "project_name" {
  description = "Project name used for naming and tagging resources."
  type        = string
  default     = "aws-eks-pipeline"
}

variable "environment" {
  description = "Deployment environment (e.g. prod, staging, dev)."
  type        = string
  default     = "prod"
}
