# Create LamdbaRole IAM Role for lambda functions
resource "aws_iam_role" "LamdbaRole" {
  name = "lambda-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "AWSLambdaBasicExecutionRole_role_policy_attachment" {
  name       = "LamdbaRole-role-policy-attachment"
  roles      = ["${aws_iam_role.LamdbaRole.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy_attachment" "AWSXRayDaemonWriteAccess_role_policy_attachment" {
  name       = "AWSXRayDaemonWriteAccess-role-policy-attachment"
  roles      = ["${aws_iam_role.LamdbaRole.name}"]
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
}