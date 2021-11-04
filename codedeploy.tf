resource "aws_codedeploy_app" "codedeploy_app" {
  compute_platform = var.compute_platform
  name             = "csye6225-webapp"
}

resource "aws_codedeploy_deployment_group" "codedeploy_deployment_group" {
  app_name              = aws_codedeploy_app.codedeploy_app.name
  deployment_group_name = "csye6225-webapp-deployment"
  service_role_arn      = aws_iam_role.CodeDeployServiceRole.arn

  deployment_style {
    deployment_type = var.deployment_type
  }

  deployment_config_name = var.deployment_config_name

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = var.webapp_name
    }
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
}