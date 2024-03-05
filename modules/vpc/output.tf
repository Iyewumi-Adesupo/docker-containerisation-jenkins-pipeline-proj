output "vpc-id" {
  value = aws_vpc.devteam.id
}

output "public-subnet1" {
  value = aws_subnet.devteam-pub1.id
}

output "public-subnet2" {
  value = aws_subnet.devteam-pub2.id
}

output "private-subnet1" {
  value = aws_subnet.devteam-priv1.id
}

output "private-subnet2" {
  value = aws_subnet.devteam-priv2.id
}
