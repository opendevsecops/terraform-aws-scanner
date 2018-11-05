output "vpc_cidr_block" {
  value = "${var.vpc_cidr_block}"
}

output "subnet_cidr_block" {
  value = "${var.subnet_cidr_block}"
}

output "name" {
  value = "${var.name}"
}

output "arn" {
  value = "${aws_ecs_cluster.main.arn}"
}

output "vpc_id" {
  value = "${aws_subnet.main.id}"
}

output "subnet_id" {
  value = "${aws_subnet.main.id}"
}

output "task_role_arn" {
  value = "${aws_iam_role.task_role.arn}"
}

output "task_role_name" {
  value = "${aws_iam_role.task_role.name}"
}

output "execution_role_arn" {
  value = "${aws_iam_role.execution_role.arn}"
}

output "execution_role_name" {
  value = "${aws_iam_role.execution_role.name}"
}
