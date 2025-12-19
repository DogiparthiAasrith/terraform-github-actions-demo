terraform {
  backend "s3" {
    bucket = "terraform-state-demo-12345"
    key    = "ec2/terraform.tfstate"
    region = "us-west-2"   # ✅ MUST MATCH BUCKET REGION
  }
}
