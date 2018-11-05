data "aws_region" "current" {}

locals {
  log_group             = "/ecs/${var.name}"
  log_retention_in_days = "${var.log_retention_in_days}"
}

resource "aws_iam_role" "task_role" {
  description = "Allows ECS to operate on task (task: ${var.name})."

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

resource "aws_iam_role_policy_attachment" "task_role_policy_attachment" {
  role       = "${aws_iam_role.task_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "execution_role" {
  description = "Allows ECS tasks to operate on AWS services (task: ${var.name})."

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

resource "aws_iam_role_policy" "execution_role_policy" {
  name = "policy"
  role = "${aws_iam_role.execution_role.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Action": "*",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_cloudwatch_log_group" "main" {
  name              = "${local.log_group}"
  retention_in_days = "${local.log_retention_in_days}"
}

resource "aws_ecs_task_definition" "main" {
  family = "${var.name}"

  task_role_arn      = "${aws_iam_role.task_role.arn}"
  execution_role_arn = "${aws_iam_role.execution_role.arn}"

  network_mode = "awsvpc"

  requires_compatibilities = ["FARGATE"]

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
