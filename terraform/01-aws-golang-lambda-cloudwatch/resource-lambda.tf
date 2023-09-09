data "archive_file" "lambda" {
  type        = "zip"
  source_file = "dist/main"
  output_path = "dist/lambda_function_payload.zip"
}

resource "aws_lambda_function" "test_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "${path.module}/dist/lambda_function_payload.zip"
  function_name = var.lambda_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "main"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "go1.x"

	depends_on = [ 
		aws_iam_role_policy_attachment.lambda_logs,
		aws_cloudwatch_log_group.lambda_log_group,
	 ]

  environment {
    variables = {
      sample_key = "sample_data"
    }
  }
}

# Function URL
resource "aws_lambda_function_url" "lambda_function_url" {
	function_name = aws_lambda_function.test_lambda.function_name
	authorization_type = "NONE"

	cors {
		allow_credentials = true
		allow_origins = ["*"]
		allow_methods = ["*"]
		allow_headers = ["date", "keep-alive"]
		expose_headers = ["date", "keep-alive"]
		max_age = 86400
	}
}
