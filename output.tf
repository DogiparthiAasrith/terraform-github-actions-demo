output "ec2_instance_id" {
  value = aws_instance.demo_ec2.id
}

output "lambda_function_name" {
  value = aws_lambda_function.demo_lambda.function_name
}

output "api_gateway_url" {
  value = aws_apigatewayv2_api.http_api.api_endpoint
}

output "native_lock_test_bucket_name" {
  value = aws_s3_bucket.native_lock_test_bucket.bucket
}

output "native_lock_test_iam_user" {
  value = aws_iam_user.native_lock_test_user.name
}
