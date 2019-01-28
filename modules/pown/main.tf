module "main" {
  source = "../_scanner"

  schedule = "${var.schedule}"

  task_name = "opendevsecops_scanner_pown"
  task_args = "${var.args}"

  trigger_arn = "${var.trigger_arn}"
}
