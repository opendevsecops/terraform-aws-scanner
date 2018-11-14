locals {
  args = ["${var.target}"]
}

module "main" {
  source = "../_scanner"

  schedule = "${var.schedule}"

  task_name = "opendevsecops_scanner_nmap"
  task_args = "${concat(var.flags, local.args)}"

  trigger_arn = "${var.trigger_arn}"
}
