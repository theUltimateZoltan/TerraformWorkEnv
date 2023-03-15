terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "this" {
  ami           = "ami-0df24e148fdb9f1d8" # amazon linux default
  instance_type = "t2.micro"

  tags = {
    "provisioner" = "terraform"
  }
}

