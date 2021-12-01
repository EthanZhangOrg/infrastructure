resource "aws_launch_configuration" "as_conf" {
  name                        = "asg_launch_config"
  image_id                    = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.ssh_key.key_name
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.iam_instance_profile.name
  security_groups             = [aws_security_group.application.id]

  user_data = <<EOF
#!/bin/bash

####################################################
# Configure Webapp Properties                      #
####################################################
cd /home/ubuntu
mkdir webapp_jar
cd webapp_jar
touch application.properties
echo "spring.datasource.jdbcUrl=jdbc:mysql://${aws_db_instance.db_instance.endpoint}/csye6225" >> application.properties
echo "spring.datasource.username=${aws_db_instance.db_instance.username}" >> application.properties
echo "spring.datasource.password=${aws_db_instance.db_instance.password}" >> application.properties
echo "db2.datasource.jdbcUrl=jdbc:mysql://${aws_db_instance.db_instance_replica.endpoint}/csye6225" >> application.properties
echo "db2.datasource.username=${aws_db_instance.db_instance.username}" >> application.properties
echo "db2.datasource.password=${aws_db_instance.db_instance.password}" >> application.properties
echo "cloud.aws.region=${var.region}" >> application.properties
echo "s3.bucket.name=${aws_s3_bucket.s3_bucket.bucket}" >> application.properties
echo "sns.topic.arn=${aws_sns_topic.sns_topic.arn}" >> application.properties
chown ubuntu:ubuntu application.properties
cd ..
chown ubuntu:ubuntu webapp_jar
  EOF
}

resource "aws_autoscaling_group" "autoscaling_group" {
  name                 = "webapp-autoscaling_group"
  default_cooldown     = 60
  launch_configuration = aws_launch_configuration.as_conf.name
  max_size             = 5
  min_size             = 3
  desired_capacity     = 3
  vpc_zone_identifier  = [for s in aws_subnet.subnet : s.id]
  target_group_arns    = [aws_lb_target_group.lb_target_group.arn]

  tag {
    key                 = "Name"
    value               = var.webapp_name
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "autoscaling_policy_up" {
  name                   = "scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 120
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.name
}

resource "aws_cloudwatch_metric_alarm" "cloudwatch_metric_alarm_up" {
  alarm_name          = "cpu-usage-max"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "5"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.autoscaling_group.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization, if it's above 5%, scale up 1 instance"
  alarm_actions     = [aws_autoscaling_policy.autoscaling_policy_up.arn]
}

resource "aws_autoscaling_policy" "autoscaling_policy_down" {
  name                   = "scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 120
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.name
}

resource "aws_cloudwatch_metric_alarm" "cloudwatch_metric_alarm_down" {
  alarm_name          = "cpu-usage-min"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "3"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.autoscaling_group.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization, if it's above 5%, scale up 1 instance"
  alarm_actions     = [aws_autoscaling_policy.autoscaling_policy_down.arn]
}