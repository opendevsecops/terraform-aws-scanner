variable "schedule" {}

variable "target" {}

variable "flags" {
  default = ["-sS", "-F"]
}

variable "trigger_arn" {}
