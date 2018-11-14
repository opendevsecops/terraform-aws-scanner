module "main" {
  source = "../_scanner"

  schedule = "${var.schedule}"

  task_name = "opendevsecops_scanner_amass"
  task_args = ["-d", "${var.target}"]

  trigger_arn = "${var.trigger_arn}"
}
