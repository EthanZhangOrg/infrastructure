data "aws_iam_policy_document" "dynamodb_policy_document" {
  statement {
    actions = ["dynamodb:PutItem",
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:UpdateItem"
    ]
    resources = ["arn:aws:dynamodb:*:${var.aws_account_id}:table/*"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "dynamodb_policy" {
  name   = "dynamodb-policy"
  policy = data.aws_iam_policy_document.dynamodb_policy_document.json
}

resource "aws_iam_policy_attachment" "dynamodb_policy_attachment" {
  name       = "dynamodb-policy-attachment"
  roles      = ["${aws_iam_role.CodeDeployEC2ServiceRole.name}"]
  policy_arn = aws_iam_policy.dynamodb_policy.arn
}

resource "aws_iam_policy_attachment" "dynamodb_lambda_policy_attachment" {
  name       = "dynamodb-policy-lambda-attachment"
  roles      = ["${aws_iam_role.LamdbaRole.name}"]
  policy_arn = aws_iam_policy.dynamodb_policy.arn
}