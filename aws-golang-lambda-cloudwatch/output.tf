output "lambda_environment" {
	value = aws_lambda_function.test_lambda.environment
}

output "lambda_function_url" {
	value = aws_lambda_function_url.lambda_function_url.function_url
	description = "This URL is used to call the lambda function"
}