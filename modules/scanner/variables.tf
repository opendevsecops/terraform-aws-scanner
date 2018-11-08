variable "schedule" {
  description = "The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes)"
  type        = "string"
}

variable "task_name" {
  description = "The name of the ECS task to execute"
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
