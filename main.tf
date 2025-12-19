resource "aws_instance" "demo_ec2" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 (us-east-1)
  instance_type = var.instance_type

  tags = {
    Name = "GitHub-Actions-EC2"
  }
}
