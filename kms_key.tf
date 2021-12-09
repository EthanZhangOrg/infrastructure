resource "aws_kms_key" "kms_key" {
  description             = "KMS key 1"
  deletion_window_in_days = 10
}

resource "aws_kms_key" "kms_key_ebs" {
  description             = "KMS key for ebs volume"
  deletion_window_in_days = 10
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Id" : "key-default-1",
    "Statement" : [
      {
        "Sid" : "Enable IAM User Permissions",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::${var.aws_account_id}:root"
        },
        "Action" : "kms:*",
        "Resource" : "*"
      },
      {
        "Sid" : "Enable IAM User Permissions",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::${var.aws_account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
        },
        "Action" : "kms:*",
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_ebs_encryption_by_default" "example" {
  enabled = true
}