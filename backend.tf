terraform {
  backend "s3" {
    bucket = "terraform-tfstate-aasrith-2025-usw2"
    key    = "ec2/terraform.tfstate"
    region = "us-east-1"   # ✅ MUST MATCH BUCKET REGION
  }
}
