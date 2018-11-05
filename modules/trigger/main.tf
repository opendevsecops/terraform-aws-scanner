module "lambda" {
  source  = "opendevsecops/lambda/aws"
  version = "0.1.0"

  source_dir  = "${path.module}/src"
  output_path = "${path.module}/build/lambda.zip"

  name      = "${var.name}"
  role_name = "${var.role_name}"

  timeout               = 900
  log_retention_in_days = 90

  environment {
    CLUSTER       = "${var.cluster_arn}"
    SUBNET        = "${var.subnet_id}"
    TASK_ROLE_ARN = "${var.task_role_arn}"
  }
}

resource "aws_iam_role_policy" "policy" {
  role = "${var.role_name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ecs:RunTask",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "iam:PassRole",
      "Resource": "${var.task_role_arn}"
    }
  ]
}
EOF
}
