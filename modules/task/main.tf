data "aws_region" "current" {}

locals {
  log_group             = "/ecs/${var.name}"
  log_retention_in_days = "${var.log_retention_in_days}"
}

resource "aws_cloudwatch_log_group" "main" {
  name              = "${local.log_group}"
  retention_in_days = "${local.log_retention_in_days}"
}

resource "aws_iam_role" "main" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "main" {
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
        "${aws_iam_role.main.arn}:*:*",
        "${aws_iam_role.main.arn}"
      ]
    }
  ]
}
EOF
}

resource "aws_ecs_task_definition" "main" {
  family = "${var.name}"

  network_mode = "awsvpc"

  requires_compatibilities = ["FARGATE"]

  execution_role_arn = "${aws_iam_role.main.arn}"

  cpu    = 512
  memory = 1024

  container_definitions = <<EOF
[
  {
    "name": "${var.name}",
    "image": "${var.image}",
    "essential": true,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${local.log_group}",
        "awslogs-region": "${data.aws_region.current.name}",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]
EOF
}
