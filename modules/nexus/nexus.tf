locals {
  nexus_userdata = <<-EOF
#!/bin/bash
sudo apt update
sudo hostnamectl set-hostname nexus
sudo apt-get install openjdk-8-jdk
sudo apt-get update
cd /opt
sudo wget http://download.sonatype.com/nexus/3/nexus-3.23.0-03-unix.tar.gz
sudo tar -xvf nexus-3.23.0-03-unix.tar.gz
sudo mv nexus-3.23.0-03 nexus
sudo adduser nexus
sudo chown -R nexus:nexus /opt/nexus
sudo chown -R nexus:nexus /opt/sonatype-work
sudo sed -i 'a run_as_user="nexus" ' /opt/nexus/bin/nexus.rc
su - nexus
/opt/nexus/bin/nexus start
EOF
}
