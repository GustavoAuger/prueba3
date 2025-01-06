resource "aws_sqs_queue" "sqs_prueba3" {
  name = var.sqs_queue_arn  # Usamos la variable para definir el nombre de la cola
}
