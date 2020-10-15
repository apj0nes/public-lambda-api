resource "aws_lambda_function" "lambda_api" {
  function_name = "${module.naming.aws_lambda}"
  handler = "lambda.handler"
  role = "${aws_iam_role.lambda_role.arn}"
  runtime = "${var.lambda_runtime}"
  memory_size = "${var.lambda_memory}"
  publish = true
  timeout = 120
  filename = "build.zip"
  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  environment = {
    variables = "${var.application_environment_variables}"
  }

  vpc_config = {
    subnet_ids = ["${data.terraform_remote_state.vpc.subnets_private}"]
    security_group_ids = ["${data.terraform_remote_state.vpc.sg_common}"]
  }
}

data "archive_file" "lambda_zip" {
  type = "zip"
  source_dir = "${var.lambda_build_folder}"
  output_path = "build.zip"
}

resource "aws_lambda_permission" "alb_invoke" {
  statement_id = "AllowExecutionFromALB"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda_api.function_name}"
  principal = "elasticloadbalancing.amazonaws.com"
  source_arn = "${aws_alb_target_group.alb_tg.arn}"
}