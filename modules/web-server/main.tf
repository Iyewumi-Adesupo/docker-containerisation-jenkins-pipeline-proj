#creating aws instance
resource "aws_instance" "webserver" {
  ami      = var.ami
  instance_type = "t2.medium"
  associate_public_ip_address = true
  key_name = var.public_key
  subnet_id = var.pub-subnet
  vpc_security_group_ids = [ var.security-grp ]
  user_data = local.web-userdata
  tags = {
    Name = "webserver"
  }
}