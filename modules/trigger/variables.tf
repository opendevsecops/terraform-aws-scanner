variable "name" {
  description = "A unique name for your Lambda Function"
  default     = "opendevsecops_scanner_trigger"
}

variable "role_name" {
  description = "A unique name for your Lambda Function Role"
  default     = "opendevsecops_scanner_trigger_role"
}

variable "cluster_arn" {
  description = "The cluster arn dedicated for task execution"
}

variable "subnet_id" {
  description = "The subnet id dedicated for task execution"
}

variable "task_role_arn" {
  type = "string"
}
