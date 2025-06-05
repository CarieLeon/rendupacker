terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "vmfrontend" {
  ami           = "ami-069efff68095b0a92"
  instance_type = "t3.micro"
  key_name      = "terraform_ec2_key"

  tags = {
    Name = "VMFRONTEND"
  }
}

resource "aws_instance" "vmbackend" {
  ami           = "ami-07c0871b570f0acbd"
  instance_type = "t3.micro"
  key_name      = "terraform_ec2_key"

  tags = {
    Name = "VMBACKEND"
  }
}
resource "aws_instance" "vmdatabase" {
  ami           = "ami-0ed32860e7e138940"
  instance_type = "t3.micro"
  key_name      = "terraform_ec2_key"

  tags = {
    Name = "VMDATABASE"
  }
}

resource "aws_key_pair" "terraform_ec2_key" {
  key_name   = "terraform_ec2_key"
  public_key = file("terraform_ec2_key.pub")
}
