resource "aws_api_gateway_rest_api" "test-api" {
  name        = var.api_gateway_api_name
  description = "Proxy to handle requests to our API"
}

# resource "aws_apigatewayv2_api" "test-api" {
#   name          = var.api_gateway_api_name
# 	description = "APIs for Test API"
#   protocol_type = "HTTP"
# 	cors_configuration {
# 		allow_credentials = "*"
# 		allow_headers = "*"
# 		allow_methods = "*"
# 		allow_origins = "*"
# 	}
# }

resource "aws_api_gateway_resource" "gw_resource" {
  rest_api_id = aws_api_gateway_rest_api.test-api.id
  parent_id   = aws_api_gateway_rest_api.test-api.root_resource_id
  path_part   = "{proxy+}"
}
# For root resource
# resource "aws_api_gateway_method" "proxy_root" {
#   rest_api_id   = "${aws_api_gateway_rest_api.test-api.id}"
#   resource_id   = "${aws_api_gateway_rest_api.test-api.root_resource_id}"
#   http_method   = "ANY"
#   authorization = "NONE"
# }
# resource "aws_api_gateway_integration" "lambda_root" {
#   rest_api_id = "${aws_api_gateway_rest_api.test-api.id}"
#   resource_id = "${aws_api_gateway_method.proxy_root.resource_id}"
#   http_method = "${aws_api_gateway_method.proxy_root.http_method}"

#   integration_http_method = "POST"
#   type                    = "AWS_PROXY"
#   uri                     = "${aws_lambda_function.test_lambda.invoke_arn}"
# }

# For proxy resource
resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = "${aws_api_gateway_rest_api.test-api.id}"
  resource_id   = "${aws_api_gateway_resource.gw_resource.id}"
  http_method   = "ANY"
  authorization = "NONE"
}
resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = "${aws_api_gateway_rest_api.test-api.id}"
  resource_id = "${aws_api_gateway_method.proxy.resource_id}"
  http_method = "${aws_api_gateway_method.proxy.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.test_lambda.invoke_arn}"
}

resource "aws_api_gateway_deployment" "example" {
  depends_on = [
    aws_api_gateway_integration.lambda,
  ]

  rest_api_id = aws_api_gateway_rest_api.test-api.id
  stage_name  = "test"
}

# resource "aws_api_gateway_model" "MyDemoModel" {
#   rest_api_id  = aws_api_gateway_rest_api.test-api.id
#   name         = "user"
#   description  = "A JSON schema"
#   content_type = "application/json"

#   schema = jsonencode({
#     type = "object"
#   })
# }

# resource "aws_api_gateway_method_response" "response_200" {
#   rest_api_id = aws_api_gateway_rest_api.test-api.id
#   resource_id = aws_api_gateway_resource.gw_resource.id
#   http_method = aws_api_gateway_method.proxy.http_method
#   status_code = "200"
# }

# resource "aws_api_gateway_integration_response" "MyDemoIntegrationResponse" {
#   rest_api_id = aws_api_gateway_rest_api.test-api.id
#   resource_id = aws_api_gateway_resource.gw_resource.id
#   http_method = aws_api_gateway_method.proxy.http_method
#   status_code = aws_api_gateway_method_response.response_200.status_code

#   # Transforms the backend JSON response to XML
#   response_templates = {
#     "application/json" = <<EOF
# {
#   "$id": "https://example.com/person.schema.json",
#   "$schema": "https://json-schema.org/draft/2020-12/schema",
#   "title": "Message",
#   "type": "object",
#   "properties": {
#     "answer": {
#       "type": "string",
#       "description": "response message in string"
#     }
#   }
# }
# EOF
#   }
# }