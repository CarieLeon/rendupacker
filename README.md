# 🚀 Projet Infrastructure Cloud avec Terraform

## 📋 Description

Ce projet démontre l'automatisation du déploiement d'une infrastructure cloud sur AWS en utilisant Terraform. L'infrastructure comprend trois machines virtuelles distinctes pour une architecture à trois niveaux : frontend, backend et base de données.

## 🏗️ Architecture

L'infrastructure déployée comprend :

- **VM Frontend** (`vmfrontend`)

  - Instance type: t3.micro
  - AMI: ami-069efff68095b0a92
  - Rôle: Interface utilisateur

- **VM Backend** (`vmbackend`)

  - Instance type: t3.micro
  - AMI: ami-07c0871b570f0acbd
  - Rôle: Logique métier

- **VM Database** (`vmdatabase`)
  - Instance type: t3.micro
  - AMI: ami-0ed32860e7e138940
  - Rôle: Stockage des données

## 🛠️ Configuration Technique

### Prérequis

- Terraform (version >= 1.2.0)
- AWS CLI configuré
- Clé SSH publique (`terraform_ec2_key.pub`)

### Configuration Terraform

```hcl
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

## 🚀 Déploiement

### 1. Initialisation

```bash
terraform init
```

### 2. Vérification du plan

```bash
terraform plan
```

### 3. Déploiement

```bash
terraform apply
```

## 🔐 Connexion aux instances

Pour se connecter à une instance :

```bash
ssh -i terraform_ec2_key ubuntu@<DNS_IPV4_PUBLIC>
```

### Vérification des services

Une fois connecté, vérifiez l'état des services avec :

```bash
systemctl status <nom_du_service>
```

## 🔑 Gestion des clés

- Une paire de clés SSH est automatiquement créée
- La clé publique est lue depuis le fichier `terraform_ec2_key.pub`
- La clé privée doit être conservée en local pour les connexions SSH

## 🎯 Avantages

- Déploiement automatisé de l'infrastructure complète
- Configuration cohérente et reproductible
- Gestion centralisée des ressources
- Gain de temps significatif dans le déploiement
