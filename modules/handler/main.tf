module "lambda" {
  source  = "opendevsecops/lambda/aws"
  version = "0.1.0"

  source_dir  = "${path.module}/src"
  output_path = "${path.module}/build/lambda.zip"

  name      = "opendevsecops_scanner_handler"
  role_name = "opendevsecops_scanner_handler_role"

  timeout               = 900
  log_retention_in_days = 90
}
