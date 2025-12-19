output "ec2_instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.demo_ec2.id
}

output "ec2_public_ip" {
  description = "Public IP address of EC2"
  value       = aws_instance.demo_ec2.public_ip
}

output "ec2_public_dns" {
  description = "Public DNS of EC2"
  value       = aws_instance.demo_ec2.public_dns
}
