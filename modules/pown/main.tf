module "main" {
  source = "../_scanner"

  schedule = "${var.schedule}"

  task_name = "opendevsecops_scanner_pown"
  task_args = ["scanner", "${var.target}"]

  trigger_arn = "${var.trigger_arn}"
}
