module "main" {
  source = "../_scanner"

  schedule = "${var.schedule}"

  task_name = "opendevsecops_scanner_nikto"
  task_args = ["-host", "${var.target}"]

  trigger_arn = "${var.trigger_arn}"
}
