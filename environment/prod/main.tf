variable "function_name" {}
locals {
  function_name = "sample-lambda"
}

data "archive_file" "function_source" {
  type        = "zip"
  source_dir  = "../../app"
  output_path = "../../archive/new.zip"
}

resource "aws_lambda_function" "function" {
  function_name = var.function_name
  handler       = "new.lambda_handler"
  runtime       = "python3.9"

  filename         = data.archive_file.function_source.output_path
  source_code_hash = data.archive_file.function_source.output_base64sha256
}