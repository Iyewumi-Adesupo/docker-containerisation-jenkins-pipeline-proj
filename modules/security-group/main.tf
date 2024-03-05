#creating security group for webserver
resource "aws_security_group" "web-server" {
  name        = "web-server"
  description = "Allow inbound traffic from port 22 and 8080"
  vpc_id      = var.vpc-id
  
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  ingress {
    from_port        = 8083
    to_port          = 8083
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }

   tags = {
    Name = "web-server"
    }
}

#creating RDS security group
resource "aws_security_group" "MYSQL" {
  name        = "MySQL"
  description = "Allow traffic from port 3306"
  vpc_id      = var.vpc-id

  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "TCP"
    security_groups = [ aws_security_group.web-server.id ]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  tags = {
    Name = "RDS-secgrp"
  }
}

resource "aws_security_group" "nexus" {
  name        = "nexus"
  description = "Allow inbound traffic from port 22 and 8081"
  vpc_id      = var.vpc-id
  
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    
  } 

  ingress {
    from_port        = 5000
    to_port          = 5000
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  ingress {
    from_port        = 8081
    to_port          = 8081
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }

   tags = {
    Name = "nexus"
    }
}

resource "aws_security_group" "jenkins-master" {
  name        = "jenkins-master"
  description = "Allow inbound traffic from port 22 and 8080"
  vpc_id      = var.vpc-id
  
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  ingress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }

   tags = {
    Name = "jenkins-master"
    }
}

resource "aws_security_group" "jenkins-slave" {
  name        = "jenkins-slave"
  description = "Allow inbound traffic from port 22 and 8080"
  vpc_id      = var.vpc-id
  
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }

   tags = {
    Name = "jenkins-slave"
    }
}