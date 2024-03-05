resource "aws_db_instance" "RDS" {
  allocated_storage    = 10
  db_name              = "petclinic"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "petclinic"
  password             = "petclinic"
  vpc_security_group_ids = [ var.security-grp ]
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  multi_az = true
  db_subnet_group_name = aws_db_subnet_group.db-subnet.id
}

resource "aws_db_subnet_group" "db-subnet" {
  name       = "rds"
  subnet_ids = [var.priv-subnet1, var.priv-subnet2]

  tags = {
    Name = "db-subnet"
  }
}