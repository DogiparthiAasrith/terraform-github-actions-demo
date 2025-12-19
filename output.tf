output "ec2_instance_id" {
  value = aws_instance.demo_ec2.id
}

output "lambda_function_name" {
  value = aws_lambda_function.demo_lambda.function_name
}

output "api_gateway_url" {
  value = aws_apigatewayv2_api.http_api.api_endpoint
}
