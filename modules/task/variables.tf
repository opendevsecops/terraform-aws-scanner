variable "name" {
  description = "The name for this task"
  type        = "string"
}

variable "image" {
  description = "The image for this task"
  type        = "string"
}

variable "log_retention_in_days" {
  description = "Specifies the number of days you want to retain log events"
  default     = 30
}
