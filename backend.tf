terraform {
  required_version = ">= 1.11.0"

  backend "s3" {
    # 🔹 Existing S3 bucket (must already exist)
    bucket = "terraform-tfstate-aasrith-2025-usw2"

    # 🔹 State file path
    key = "ec2/terraform.tfstate"

    # ✅ MUST match the bucket's actual region
    region = "us-west-2"

    # ✅ Native S3 locking (NO DynamoDB)
    use_lockfile = true

    # 🔐 Encrypt state file at rest
    encrypt = true
  }
}



