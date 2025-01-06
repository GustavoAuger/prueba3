output "ecr_repository_uri" {
  value = aws_ecr_repository.app_repository.repository_url
}