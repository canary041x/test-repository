data "archive_file" "layer_file_requests" {
  type        = "zip"
  source_dir  = "../../layer/layer_requests"
  output_path = "../../archive/layer_requests.zip"
}

data "archive_file" "layer_file_jira" {
  type        = "zip"
  source_dir  = "../../layer/layer_jira"
  output_path = "../../archive/layer_jira.zip"
}

data "archive_file" "function_source" {
  type        = "zip"
  source_dir  = "../../app"
  output_path = "../../archive/new.zip"
}

resource "aws_lambda_layer_version" "lambda_layer_requests" {
  layer_name = "lambda-layer-requests"
  filename   = "${data.archive_file.layer_file_requests.output_path}"
  source_code_hash = "${data.archive_file.layer_file_requests.output_base64sha256}"
}

resource "aws_lambda_layer_version" "lambda_layer_jira" {
  layer_name = "lambda-layer-jira"
  filename   = "${data.archive_file.layer_file_jira.output_path}"
  source_code_hash = "${data.archive_file.layer_file_jira.output_base64sha256}"
}

resource "aws_lambda_function" "function" {
  function_name    = "git-lambda"
  handler          = "new.lambda_handler"
  role             = var.role_arn
  runtime          = "python3.9"
  timeout          = 300
  filename         = data.archive_file.function_source.output_path
  source_code_hash = data.archive_file.function_source.output_base64sha256
  layers           = [
    "${aws_lambda_layer_version.lambda_layer_requests.arn}",
    "${aws_lambda_layer_version.lambda_layer_jira.arn}"
  ]                  

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

}