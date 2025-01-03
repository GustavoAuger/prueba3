resource "aws_ecr_repository" "app_repository" {
  name                 = var.ecr_name
  image_tag_mutability = "MUTABLE"
  encryption_configuration {
    encryption_type = "AES256"
  }
}