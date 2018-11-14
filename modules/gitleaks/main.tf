module "main" {
  source = "../_scanner"

  schedule = "${var.schedule}"

  task_name = "opendevsecops_scanner_gitleaks"
  task_args = ["-v", "-r", "${var.target}"]

  trigger_arn = "${var.trigger_arn}"
}
