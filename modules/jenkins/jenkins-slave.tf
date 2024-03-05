locals {
  jenkins-slave = <<-EOF
#!/bin/bash
sudo yum update -y
sudo yum install git -y
sudo yum install maven -y
sudo mkdir /opt/build
sudo chmod 777 /opt/build
cd /home/ec2user
EOF
}