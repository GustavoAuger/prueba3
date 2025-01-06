resource "aws_route_table" "route_table_prueba3" {
  vpc_id=var.vpc_id
  tags={Name=var.name,Environment=var.environment}
}

resource "aws_route" "route_prueba3" {
  route_table_id=aws_route_table.route_table_prueba3.id
  destination_cidr_block="0.0.0.0/0"
  gateway_id=var.gateway_id
}
resource "aws_route_table_association" "subnet_association" {
  subnet_id      = var.public_subnet_id
  route_table_id = aws_route_table.route_table_prueba3.id
}