output "jenkins-master" {
  value = aws_instance.jenkins-master.public_ip
}

output "jenkins-slave" {
  value = aws_instance.jenkins-slave.public_ip
}