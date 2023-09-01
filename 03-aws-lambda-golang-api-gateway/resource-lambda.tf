data "archive_file" "lambda" {
  type        = "zip"
  source_file = "dist/main"
  output_path = "dist/lambda_function_payload.zip"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com",
        "apigateway.amazonaws.com",
      ]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = var.lambda_assume_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "logs" {
  name   = "lambda-logs"
  role   = aws_iam_role.iam_for_lambda.name
  policy = jsonencode({
    "Statement": [
      {
        "Action": [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:logs:*:*:*",
      }
    ]
  })
}

resource "aws_lambda_function" "test_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename = "${path.module}/dist/lambda_function_payload.zip"
  handler  = "main"
  runtime  = "go1.x"

  function_name = var.lambda_name
  role          = aws_iam_role.iam_for_lambda.arn

  source_code_hash = data.archive_file.lambda.output_base64sha256

}

# resource "aws_lambda_function_url" "lambda_function_url" {
# 	function_name = aws_lambda_function.test_lambda.function_name
# 	authorization_type = "NONE"
# }

# resource "aws_lambda_alias" "live" {
#   name = "live"
#   description = "Live alias"
#   function_name = aws_lambda_function.test_lambda.arn
#   function_version = aws_lambda_function.test_lambda.version
# }

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.test_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  # qualifier = aws_lambda_alias.live.name

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  # source_arn = "arn:aws:execute-api:${var.region}:${var.account_id}:${aws_api_gateway_rest_api.test-api.id}/*/${aws_api_gateway_method.method.http_method}${aws_api_gateway_resource.gw_resource.path}"

  # arn:aws:lambda:ap-south-1:030907810968:function:lambda_golang_poc_2

  # The /* part allows invocation from any stage, method and resource path
  # within API Gateway.
  source_arn = "${aws_api_gateway_rest_api.test-api.execution_arn}/*"
}