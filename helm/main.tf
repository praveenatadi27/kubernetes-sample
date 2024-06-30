locals {
  aws_region       = "us-east-1"
  environment_name = "staging"
  tags = {
    ops_env              = "${local.environment_name}"
    ops_managed_by       = "terraform",
    ops_source_repo      = "kubernetes-ops",
    ops_source_repo_path = "terraform-environments/aws/${local.environment_name}/helm/sample-app",
    ops_owners           = "devops",
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.37.0"
    }
    random = {
      source = "hashicorp/random"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.3.0"
    }
  }

  cloud {
    organization = "praveena-tadi-org"

    workspaces {
      name = "kubernetes-ops-staging-20-eks"
    }
  }
}

provider "aws" {
  region = local.aws_region
}

output "module_path" {
  value = path.module
}

resource "aws_s3_bucket" "example" {
  bucket = "example-bucket-${terraform.workspace}"
  acl    = "private"
}

