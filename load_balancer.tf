resource "aws_lb" "load_balancer" {
  name               = "webapp-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.load_balancer.id]
  subnets            = [for s in aws_subnet.subnet : s.id]

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "lb_target_group" {
  name     = "webapp-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}