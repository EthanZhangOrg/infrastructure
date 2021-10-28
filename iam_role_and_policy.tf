data "aws_iam_policy_document" "iam_policy_document" {
  statement {
    actions = ["s3:DeleteObject",
      "s3:PutObject",
      "s3:GetObject"
    ]
    resources = [aws_s3_bucket.s3_bucket.arn, "${aws_s3_bucket.s3_bucket.arn}/*"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "iam_policy" {
  name = var.iam_policy_name

  policy = data.aws_iam_policy_document.iam_policy_document.json

}

resource "aws_iam_role" "iam_role" {
  name = var.iam_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "iam_policy_attachment" {
  name       = var.iam_policy_attachment_name
  roles      = ["${aws_iam_role.iam_role.name}"]
  policy_arn = aws_iam_policy.iam_policy.arn
}

resource "aws_iam_instance_profile" "iam_instance_profile" {
  name  = var.iam_instance_profile_name
  role = aws_iam_role.iam_role.name
}

