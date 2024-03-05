output "MySQL-sg" {
  value = aws_security_group.MYSQL.id
}

output "web-server" {
  value = aws_security_group.web-server.id
}

output "nexus-sg" {
  value = aws_security_group.nexus.id
}

output "jenkins-mastersg" {
  value = aws_security_group.jenkins-master.id
}