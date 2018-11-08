module "main" {
  source = "../scanner"

  schedule = "${var.schedule}"

  task_name = "opendevsecops_scanner_wpscan"
  task_args = ["--no-update", "--url", "${var.target}"]

  trigger_arn = "${var.trigger_arn}"
}
