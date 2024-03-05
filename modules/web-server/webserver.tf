locals {
  web-userdata = <<-EOF
#!/bin/bash
sudo apt update
sudo hostnamectl set-hostname webserver
sudo apt install openjdk-11-jre-headless -y
sudo apt install maven -y
sudo apt  install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ubuntu
EOF
}