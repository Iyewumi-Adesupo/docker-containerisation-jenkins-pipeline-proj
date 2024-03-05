output "webserver-ip" {
  value = module.webserver.web-public-ip
}

output "nexus-ip" {
  value = module.nexus.nexus-server
}

output "jenkins-ip" {
  value = module.jenkins.jenkins-master
}

output "jenkins-slaveip" {
  value = module.jenkins.jenkins-slave
}