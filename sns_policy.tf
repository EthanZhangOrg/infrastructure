data "aws_iam_policy_document" "sns_policy_document" {
  statement {
    actions   = ["sns:Publish"]
    resources = [aws_sns_topic.sns_topic.arn]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "sns_policy" {
  name   = "sns-policy"
  policy = data.aws_iam_policy_document.sns_policy_document.json
}

resource "aws_iam_policy_attachment" "sns_policy_attachment" {
  name       = "sns-policy-attachment"
  roles      = ["${aws_iam_role.CodeDeployEC2ServiceRole.name}"]
  policy_arn = aws_iam_policy.sns_policy.arn
}