# Subred Pública
resource "aws_subnet" "subnet_publica_prueba3" {
  vpc_id=var.vpc_id
  cidr_block=var.public_subnet_cidr
  availability_zone=var.availability_zone_public
  map_public_ip_on_launch=true
  tags={Name="subnet-publica-prueba3",Environment=var.environment}
}

# Subred Privada
resource "aws_subnet" "subnet_privada_prueba3" {
  vpc_id=var.vpc_id
  cidr_block=var.private_subnet_cidr
  availability_zone=var.availability_zone_private
  map_public_ip_on_launch=false
  tags={Name="subnet-privada-prueba3",Environment=var.environment}
}
