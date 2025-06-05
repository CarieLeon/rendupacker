# rendupacker
```tf
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

```
J'ai publié mes images via terraform avec ce scripts qui me permet de créer les trois VM en une seul fois cela permet d'avoir un gain de temps 

Une fois les VM créées j'ai j'ai du me connecter en ssh via la commande suivante : ssh -i terraform_ec2_key ubuntu@(DNS Ipv4 Public)

Une fois dans la VM tester avec la commande systemctl pour voir si les services sont bien activés.

