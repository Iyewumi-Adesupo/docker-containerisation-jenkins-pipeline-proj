module "vpc" {
  source = "./modules/vpc"

}

module "security-group" {
  source = "./modules/security-group"
  vpc-id = module.vpc.vpc-id
}

module "keypair" {
  source = "./modules/keypair"
}

module "webserver" {
  source = "./modules/web-server"
  security-grp = module.security-group.web-server
  pub-subnet = module.vpc.public-subnet1
  public_key = module.keypair.public-key
  ami = "ami-0e5f882be1900e43b"
}

module "nexus" {
  source = "./modules/nexus"
  pub-subnet = module.vpc.public-subnet1
  public_key = module.keypair.public-key
  ami = "ami-0e5f882be1900e43b"
  security-grp = module.security-group.nexus-sg
}

module "jenkins" {
  source = "./modules/jenkins"
  pub-subnet = module.vpc.public-subnet1
  public_key = module.keypair.public-key
  ami = "ami-035cecbff25e0d91e"
  security-grp = module.security-group.jenkins-mastersg
}

module "rds" {
  source = "./modules/rds"
  security-grp = module.security-group.MySQL-sg
  priv-subnet1 = module.vpc.private-subnet1
  priv-subnet2 = module.vpc.private-subnet2
}