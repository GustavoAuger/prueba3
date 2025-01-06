resource "aws_internet_gateway" "igw_prueba3" {
  vpc_id=var.vpc_id
  tags={Name=var.name,Environment=var.environment}
}
