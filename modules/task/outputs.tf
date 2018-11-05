output "name" {
  value = "${var.name}"
}

output "image" {
  value = "${var.image}"
}

output "role_arn" {
  value = "${aws_iam_role.main.arn}"
}

output "role_name" {
  value = "${aws_iam_role.main.name}"
}

output "log_group" {
  value = "${local.log_group}"
}

output "log_retention_in_days" {
  value = "${local.log_retention_in_days}"
}
