variable "vpc_cidr_block" {
  description = "The cluster vpc cidr block"
  default     = "10.52.52.0/24"
}

variable "subnet_cidr_block" {
  description = "The cluster subnet cidr block"
  default     = "10.52.52.0/24"
}

variable "name" {
  description = "The name of the cluster"
  default     = "opendevsecops_scanner"
}
