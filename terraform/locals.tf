locals {
  environment         = "development"
  region              = "us-east-1"
  vpc_cidr            = "10.0.0.0/16"
  subnet_public_cidr  = "10.0.1.0/24"  # Rango de IP para subred pública
  subnet_private_cidr = "10.0.2.0/24"  # Rango de IP para subred privada
}
