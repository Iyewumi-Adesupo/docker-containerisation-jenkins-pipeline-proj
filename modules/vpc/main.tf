#Creating vpc
resource "aws_vpc" "devteam" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "dev-team"
  }
}
#Retrieving AZs from the region
data "aws_availability_zones" "devteam" {}

#Creating a public subnet 1
 resource "aws_subnet" "devteam-pub1" {
  vpc_id     = aws_vpc.devteam.id
  cidr_block = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.devteam.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "devteam-pub1"
  }
}

#Creating a public subnet 2
 resource "aws_subnet" "devteam-pub2" {
  vpc_id     = aws_vpc.devteam.id
  cidr_block = "10.0.2.0/24"
  availability_zone = data.aws_availability_zones.devteam.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "devteam-pub2"
  }
}

#creating private subnet 1
 resource "aws_subnet" "devteam-priv1" {
  vpc_id     = aws_vpc.devteam.id
  cidr_block = "10.0.3.0/24"
  availability_zone = data.aws_availability_zones.devteam.names[0]
  tags = {
    Name = "devteam-priv1"
  }
}

#Creating a private subnet 2
 resource "aws_subnet" "devteam-priv2" {
  vpc_id     = aws_vpc.devteam.id
  cidr_block = "10.0.4.0/24"
  availability_zone = data.aws_availability_zones.devteam.names[1]
  tags = {
    Name = "devteam-priv2"
  }
}

#create internet gateway
resource "aws_internet_gateway" "devteamIGW" {
  vpc_id = aws_vpc.devteam.id

  tags = {
    Name = "devteamIGW"
  }
}

#Create Elastic IPs
resource "aws_eip" "devteamEIP" {
  domain = "vpc"
  depends_on = [aws_internet_gateway.devteamIGW]
}

#create NAT gateway
resource "aws_nat_gateway" "devteamNAT" {
  allocation_id = aws_eip.devteamEIP.id
  subnet_id     = aws_subnet.devteam-pub1.id

  tags = {
    Name = "devteamNAT"
  }
}

#creating public route table
resource "aws_route_table" "devteamPRT" {
  vpc_id = aws_vpc.devteam.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devteamIGW.id
  }

  tags = {
    Name = "devteamPRT"
  }
}

#creating private route table
resource "aws_route_table" "devteam-privRT" {
  vpc_id = aws_vpc.devteam.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.devteamNAT.id
  }

  tags = {
    Name = "devteam-privRT"
  }
}

#Attaching public route table to public subnet 1
resource "aws_route_table_association" "devteamRTA" {
  subnet_id      = aws_subnet.devteam-pub1.id
  route_table_id = aws_route_table.devteamPRT.id
}

#Attaching public route table to public subnet 2
resource "aws_route_table_association" "devteamRTA2" {
  subnet_id      = aws_subnet.devteam-pub1.id
  route_table_id = aws_route_table.devteamPRT.id
}

#Attaching private route table to private subnet 1
resource "aws_route_table_association" "devteamPRTA" {
  subnet_id      = aws_subnet.devteam-priv1.id
  route_table_id = aws_route_table.devteam-privRT.id
}

#Attaching private route table to private subnet 2
resource "aws_route_table_association" "devteamPRTA2" {
  subnet_id      = aws_subnet.devteam-priv2.id
  route_table_id = aws_route_table.devteam-privRT.id
}

