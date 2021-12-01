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

# CodeDeploy-EC2-S3 Policy for the Server (EC2)
data "aws_iam_policy_document" "CodeDeploy_EC2_S3_policy_document" {
  statement {
    actions = ["s3:Get*",
    "s3:List*"]
    resources = ["arn:aws:s3:::codedeploy.a5-prod", "arn:aws:s3:::codedeploy.a5-prod/*"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "CodeDeploy_EC2_S3" {
  name   = "CodeDeploy-EC2-S3"
  policy = data.aws_iam_policy_document.CodeDeploy_EC2_S3_policy_document.json
}


# GH-Upload-To-S3 Policy for GitHub Actions to Upload to AWS S3
data "aws_iam_policy_document" "GH_Upload_To_S3_policy_document" {
  statement {
    actions = ["s3:PutObject",
      "s3:Get*",
    "s3:List*"]
    resources = ["arn:aws:s3:::codedeploy.a5-prod", "arn:aws:s3:::codedeploy.a5-prod/*"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "GH_Upload_To_S3" {
  name   = "GH-Upload-To-S3"
  policy = data.aws_iam_policy_document.GH_Upload_To_S3_policy_document.json
}


# GH-Code-Deploy Policy for GitHub Actions to Call CodeDeploy
data "aws_iam_policy_document" "GH_Code_Deploy_policy_document" {
  statement {
    actions = ["codedeploy:RegisterApplicationRevision",
    "codedeploy:GetApplicationRevision"]
    resources = ["arn:aws:codedeploy:${var.region}:${var.aws_account_id}:application:${aws_codedeploy_app.codedeploy_app.name}"]
    effect    = "Allow"
  }

  statement {
    actions = ["codedeploy:CreateDeployment",
    "codedeploy:GetDeployment"]
    resources = ["*"]
    effect    = "Allow"
  }

  statement {
    actions = ["codedeploy:GetDeploymentConfig"]
    resources = ["arn:aws:codedeploy:${var.region}:${var.aws_account_id}:deploymentconfig:CodeDeployDefault.OneAtATime",
      "arn:aws:codedeploy:${var.region}:${var.aws_account_id}:deploymentconfig:CodeDeployDefault.HalfAtATime",
    "arn:aws:codedeploy:${var.region}:${var.aws_account_id}:deploymentconfig:CodeDeployDefault.AllAtOnce"]
    effect = "Allow"
  }
}

resource "aws_iam_policy" "GH_Code_Deploy" {
  name   = "GH-Code-Deploy"
  policy = data.aws_iam_policy_document.GH_Code_Deploy_policy_document.json
}


# attach needed policies to ghactions-app user
resource "aws_iam_user_policy_attachment" "GH_Upload_To_S3_user_policy_attachment" {
  policy_arn = aws_iam_policy.GH_Upload_To_S3.arn
  user       = var.iam_user_name
}

resource "aws_iam_user_policy_attachment" "GH_Code_Deploy_user_policy_attachment" {
  policy_arn = aws_iam_policy.GH_Code_Deploy.arn
  user       = var.iam_user_name
}


# Create CodeDeployEC2ServiceRole IAM Role for EC2 Instance(s)
resource "aws_iam_role" "CodeDeployEC2ServiceRole" {
  name = "CodeDeployEC2ServiceRole"
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

# attach codedeploy policies IAM Role for EC2 Instance(s)
resource "aws_iam_policy_attachment" "CodeDeploy_EC2_S3_role_policy_attachment" {
  name       = "CodeDeploy-EC2-S3-role-policy-attachment"
  roles      = ["${aws_iam_role.CodeDeployEC2ServiceRole.name}"]
  policy_arn = aws_iam_policy.CodeDeploy_EC2_S3.arn
}

resource "aws_iam_policy_attachment" "iam_policy_attachment" {
  name       = var.iam_policy_attachment_name
  roles      = ["${aws_iam_role.CodeDeployEC2ServiceRole.name}"]
  policy_arn = aws_iam_policy.iam_policy.arn
}

# attach cloudwatchagent policies IAM Role for EC2 Instance(s)
resource "aws_iam_policy_attachment" "CloudWatchAgentServerPolicy_policy_attachment" {
  name       = "CloudWatchAgentServerPolicy-attachment"
  roles      = ["${aws_iam_role.CodeDeployEC2ServiceRole.name}"]
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_policy_attachment" "CloudWatchAgentAdminPolicy_policy_attachment" {
  name       = "CloudWatchAgentAdminPolicy-attachment"
  roles      = ["${aws_iam_role.CodeDeployEC2ServiceRole.name}"]
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentAdminPolicy"
}

resource "aws_iam_policy_attachment" "AmazonEC2RoleforSSM_policy_attachment" {
  name       = "AmazonEC2RoleforSSM-attachment"
  roles      = ["${aws_iam_role.CodeDeployEC2ServiceRole.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}


# Create CodeDeployServiceRole IAM Role for CodeDeploy
resource "aws_iam_role" "CodeDeployServiceRole" {
  name = "CodeDeployServiceRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "codedeploy.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "AWS_codedeploy_role_policy_attachment" {
  name       = "AWS-codedeploy-role-policy-attachment"
  roles      = ["${aws_iam_role.CodeDeployServiceRole.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}


# attach CodeDeployEC2ServiceRole
resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = var.iam_instance_profile_name
  role = aws_iam_role.CodeDeployEC2ServiceRole.name
}




