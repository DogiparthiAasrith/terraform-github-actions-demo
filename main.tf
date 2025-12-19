# ---------------------------
# EC2 Instance
# ---------------------------
resource "aws_instance" "demo_ec2" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = var.instance_type

  tags = {
    Name = "GitHub-Actions-EC2"
  }
}

# ---------------------------
# IAM Role for Lambda
# ---------------------------
resource "aws_iam_role" "lambda_role" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# ---------------------------
# Lambda Function
# ---------------------------
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "lambda.py"
  output_path = "lambda.zip"
}

resource "aws_lambda_function" "demo_lambda" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda.lambda_handler"
  runtime       = "python3.9"
  filename      = data.archive_file.lambda_zip.output_path
}

# ---------------------------
# API Gateway (HTTP API)
# ---------------------------
resource "aws_apigatewayv2_api" "http_api" {
  name          = "demo-http-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id             = aws_apigatewayv2_api.http_api.id
  integration_type   = "AWS_PROXY"
  integration_uri    = aws_lambda_function.demo_lambda.invoke_arn
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "default_route" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "GET /"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_apigatewayv2_stage" "default_stage" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "$default"
  auto_deploy = true
}

# ---------------------------
# Permission: API Gateway → Lambda
# ---------------------------
resource "aws_lambda_permission" "api_gateway_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.demo_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.http_api.execution_arn}/*/*"
}


# ---------------------------
# Additional Service 1: S3 Bucket (for native lock testing)
# ---------------------------
resource "random_id" "s3_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "native_lock_test_bucket" {
  bucket = "native-lock-test-bucket-${random_id.s3_suffix.hex}"

  tags = {
    Name = "Native-S3-Lock-Test"
  }
}

# ---------------------------
# Additional Service 2: IAM User (for native lock testing)
# ---------------------------
resource "random_id" "iam_suffix" {
  byte_length = 4
}

resource "aws_iam_user" "native_lock_test_user" {
  name = "native-lock-test-user-${random_id.iam_suffix.hex}"
}
