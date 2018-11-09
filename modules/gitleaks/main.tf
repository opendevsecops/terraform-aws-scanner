module "main" {
  source = "../scanner"

  schedule = "${var.schedule}"

  task_name = "opendevsecops_scanner_gitleaks"
  task_args = ["-r", "${var.target}"]

  trigger_arn = "${var.trigger_arn}"
}
