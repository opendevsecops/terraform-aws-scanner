output "arn" {
  value = "${aws_lambda_function.main.arn}"
}

output "role_arn" {
  value = "${aws_iam_role.main.arn}"
}
