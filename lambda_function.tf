resource "aws_lambda_function" "lambda_function" {
  s3_bucket = "prod.lambda"
  s3_key = "serverless-0.0.1-SNAPSHOT.jar"
  function_name = "send_email"
  role          = aws_iam_role.LamdbaRole.arn
  handler       = "com.example.serverless.EmailSender::handleRequest"
  timeout = 60
  memory_size = 512

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
//   source_code_hash = filebase64sha256("webapp-0.0.1-SNAPSHOT.jar")

  runtime = "java8.al2"
}

resource "aws_lambda_permission" "with_sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.sns_topic.arn
}

resource "aws_sns_topic_subscription" "lambda" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.lambda_function.arn
}