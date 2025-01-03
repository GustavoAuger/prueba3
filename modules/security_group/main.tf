resource "aws_security_group" "sg_prueba3" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id
  tags = {
    Name        = var.name
    Environment = var.environment
  }
}

# Regla para permitir SSH desde cualquier lugar - conexión github action
resource "aws_security_group_rule" "ingress_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] # Permitir desde cualquier IP
  security_group_id = aws_security_group.sg_prueba3.id
}

# Regla para permitir acceso HTTP (puerto 80)
resource "aws_security_group_rule" "ingress_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = var.allowed_cidrs
  security_group_id = aws_security_group.sg_prueba3.id
}

# Regla para permitir acceso HTTPS (puerto 443) 
resource "aws_security_group_rule" "ingress_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.allowed_cidrs
  security_group_id = aws_security_group.sg_prueba3.id
}

# Regla para abrir el puerto 5000 para la API
resource "aws_security_group_rule" "ingress_api" {
  type              = "ingress"
  from_port         = 5000
  to_port           = 5000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] # Permitir desde cualquier IP
  security_group_id = aws_security_group.sg_prueba3.id
}

# Regla de salida (egress) permitiendo todo
resource "aws_security_group_rule" "egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_prueba3.id
}
