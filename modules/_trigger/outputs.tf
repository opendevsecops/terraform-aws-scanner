output "arn" {
  value = "${module.lambda.arn}"
}

output "role_arn" {
  value = "${module.lambda.role_arn}"
}
