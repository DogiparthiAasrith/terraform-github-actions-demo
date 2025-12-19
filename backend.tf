terraform {
  backend "s3" {
    bucket = "terraform-state-demo-12345"
    key    = "ec2/terraform.tfstate"
    region = "us-east-1"   # ✅ MUST MATCH BUCKET REGION
  }
}
