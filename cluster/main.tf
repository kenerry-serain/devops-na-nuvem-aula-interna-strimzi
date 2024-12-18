terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  assume_role {
    role_arn    = "arn:aws:iam::968225077300:role/DevOpsNaNuvemTerraformRole"
    external_id = "8d214f2c-1e8e-45cc-8924-39313dae3e0a"
  }
}
