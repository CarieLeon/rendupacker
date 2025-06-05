packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "backend" {
  ami_name      = "backend-node-ubuntu"
  instance_type = "t2.micro"
  region        = "us-west-2"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
  tags = {
    Name = "Backend-Node"
    Role = "Backend"
  }
}

build {
  name    = "backend-build"
  sources = ["source.amazon-ebs.backend"]

  provisioner "shell" {
    inline = [
      # Mise à jour des sources apt
      "sudo apt-get update -y",
      "sudo apt-get upgrade -y",

      # Ajout du dépôt universe si nécessaire
      "sudo add-apt-repository universe -y",
      "sudo apt-get update -y",

      # Installation des dépendances
      "sudo apt-get install -y curl fail2ban",

      # Installation de Node.js
      "curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -",
      "sudo apt-get update -y",
      "sudo apt-get install -y nodejs",

      # Installation de PM2 pour la gestion des processus Node.js
      "sudo npm install -g pm2",

      # Configuration de l'utilisateur packer
      "sudo useradd -m -s /bin/bash packer",
      "echo 'packer:packer' | sudo chpasswd",
      "echo 'packer ALL=(ALL) NOPASSWD:ALL' | sudo tee /etc/sudoers.d/packer",

      # Configuration de Fail2Ban
      "sudo systemctl enable fail2ban",
      "sudo systemctl start fail2ban",

      # Nettoyage
      "sudo apt-get clean",
      "sudo rm -rf /var/lib/apt/lists/*"
    ]
  }
}
Une fois le script terminer j'ai effectué les commandes suivantes afin de voir si tout semble bon : 
- terraform init
- terraform plan
- terraform apply
