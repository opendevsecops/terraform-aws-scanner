variable "schedule" {
  description = "The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes)"
  type        = "string"
}

variable "task_arn" {
  description = "The arn of the ECS task to execute"
  type        = "string"
}

variable "task_args" {
  description = "The arguments for the ECS task to execute"
  type        = "list"
}

variable "trigger_arn" {
  description = "The ARN of the trigger lambda function"
  type        = "string"
}

variable "handler_arn" {
  description = "The ARN of the handler lambda function"
  type        = "string"
}
