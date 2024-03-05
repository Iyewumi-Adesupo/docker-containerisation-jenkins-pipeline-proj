# RSA key of size 4096 bits
resource "tls_private_key" "keypair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "dev-keypair" {
  key_name   = "dev-keypair"
  public_key = tls_private_key.keypair.public_key_openssh
}

resource "local_file" "private-keypair" {
  content  = tls_private_key.keypair.private_key_pem
  filename = "${aws_key_pair.dev-keypair.key_name}.pem"
}