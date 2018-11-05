resource "aws_cloudwatch_event_rule" "main" {
  schedule_expression = "${var.schedule}"
}

resource "aws_cloudwatch_event_target" "main" {
  rule = "${aws_cloudwatch_event_rule.main.name}"
  arn  = "${var.trigger_arn}"

  input = <<EOF
{
  "task_name": ${jsonencode(var.task_name)},
  "task_args": ${jsonencode(var.task_args)},
  "handler_arn": ${jsonencode(var.handler_arn)}
}
EOF
}

resource "aws_lambda_permission" "main" {
  action        = "lambda:InvokeFunction"
  function_name = "${var.trigger_arn}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.main.arn}"
}
