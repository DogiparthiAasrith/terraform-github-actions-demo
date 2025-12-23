# Terraform AWS Infrastructure with GitHub Actions

This repository demonstrates a **production-style Terraform setup**
to provision AWS infrastructure using **GitHub Actions CI/CD** with
**OIDC-based authentication (no static credentials).**

---

## 🚀 Architecture

The infrastructure provisions the following AWS services:

- EC2 instance (compute)
- AWS Lambda function
- API Gateway (HTTP API)
- S3 bucket
- IAM roles and permissions
- Remote Terraform backend with state locking

---

## 📁 Project Structure

```text
.
├── environments/
│   └── dev/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── backend.tf
│
├── modules/
│   ├── ec2/
│   ├── lambda_api/
│   ├── s3/
│   └── iam/
│
├── lambda/
│   └── lambda.py
│
├── .github/workflows/
│   ├── terraform.yml
│   └── terraform-destroy.yml
│
├── provider.tf
├── versions.tf
└── README.md
