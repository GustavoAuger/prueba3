resource "aws_vpc" "vpc_prueba3" {
  cidr_block=var.cidr_block
  enable_dns_support=true
  enable_dns_hostnames=true
  tags={Name=var.name,Environment=var.environment}
}
