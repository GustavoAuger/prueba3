resource "aws_lambda_function" "lambda_prueba3" {
  function_name = "lambda-prueba3"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.13"
  filename      = "lambda_function.zip"

  environment {
    variables = {
      SNS_TOPIC_ARN = "arn:aws:sns:us-east-1:626635442080:sns-prueba3"  # ARN de SNS
      SQS_QUEUE_ARN = "arn:aws:sqs:us-east-1:626635442080:sqs-prueba3"  # ARN de SQS
    }
  }

  depends_on = [
    aws_iam_role.lambda_exec_role
  ]
}

resource "aws_iam_role" "lambda_exec_role" {
  name               = "lambda-execution-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions   = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "lambda_policy" {
  name   = "lambda-policy"
  role   = aws_iam_role.lambda_exec_role.id
  policy = data.aws_iam_policy_document.lambda_policy.json
}

data "aws_iam_policy_document" "lambda_policy" {
  statement {
    actions = [
      "sns:Publish",
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes"
    ]
    resources = [
      "arn:aws:sns:us-east-1:626635442080:sns-prueba3",  # ARN de SNS
      "arn:aws:sqs:us-east-1:626635442080:sqs-prueba3"   # ARN de SQS
    ]
  }
}

resource "aws_lambda_event_source_mapping" "lambda_sqs_trigger" {
  event_source_arn = "arn:aws:sqs:us-east-1:626635442080:sqs-prueba3"  # ARN de SQS
  function_name    = aws_lambda_function.lambda_prueba3.arn
  enabled          = true
}
