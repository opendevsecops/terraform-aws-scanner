data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

locals {
  name      = "${var.name}"
  role_name = "${var.role_name}"

  log_group             = "/aws/lambda/${var.name}"
  log_retention_in_days = "${var.log_retention_in_days}"

  timeout = "${var.timeout}"

  source_dir  = "${var.source_dir}"
  output_path = "${var.output_path}"

  environment = "${var.environment}"
}

resource "aws_cloudwatch_log_group" "main" {
  name              = "${local.log_group}"
  retention_in_days = "${local.log_retention_in_days}"
}

resource "aws_iam_role" "main" {
  name = "${local.role_name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "main_policy" {
  name = "policy"
  role = "${aws_iam_role.main.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": [
        "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:${local.log_group}:*:*",
        "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:${local.log_group}"
      ]
    }
  ]
}
EOF
}

data "archive_file" "main" {
  type        = "zip"
  source_dir  = "${local.source_dir}"
  output_path = "${local.output_path}"
}

resource "aws_lambda_function" "main" {
  function_name    = "${local.name}"
  handler          = "index.handler"
  runtime          = "nodejs8.10"
  filename         = "${local.output_path}"
  source_code_hash = "${data.archive_file.main.output_base64sha256}"
  role             = "${aws_iam_role.main.arn}"
  timeout          = "${local.timeout}"

  environment {
    variables = "${local.environment}"
  }
}
