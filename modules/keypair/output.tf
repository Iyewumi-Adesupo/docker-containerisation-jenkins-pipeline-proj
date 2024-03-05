output "public-key" {
  value = aws_key_pair.dev-keypair.key_name
}

output "private-key" {
  value = tls_private_key.keypair.private_key_pem
}