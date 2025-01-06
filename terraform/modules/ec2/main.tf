resource "aws_instance" "ec2_prueba3" {
  ami               = var.ami_id
  instance_type     = var.instance_type
  subnet_id         = var.public_subnet_id
  security_groups   = [var.security_group_id]  
  key_name          = var.key_name  # Uso un key que ya tenía creado con anterioridad
  tags = {
    Name        = var.name
    Environment = var.environment
  }
}
