variable "source_dir" {
  description = "The function folder to be archived"
}

variable "output_path" {
  description = "The output of the archive file"
}

variable "name" {
  description = "A unique name for your Lambda Function"
  default     = "darknet_cloudwatch_handler"
}

variable "role_name" {
  description = "A unique name for your Lambda Function"
  default     = "darknet_cloudwatch_handler_role"
}

variable "log_retention_in_days" {
  description = "Specifies the number of days you want to retain log events in lambda function log group"
  default     = 90
}

variable "timeout" {
  description = "The amount of time your Lambda Function has to run in seconds"
  default     = 900
}

variable "environment" {
  description = "A map that defines environment variables for the Lambda function."

  default = {
    dummy = "_"
  }
}

# depends_on workaround

variable "depends_on" {
  type    = "list"
  default = []
}
