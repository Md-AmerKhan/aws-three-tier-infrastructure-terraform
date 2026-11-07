
resource "aws_lb" "public" {
  name               = "terraform-3tier-public-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.public_alb_sg_id]
  subnets            = var.public_subnet_ids

  tags = {
    Name = "terraform-3tier-public-alb"
  }
}

resource "aws_lb_target_group" "web" {
  name     = "terraform-3tier-web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "public" {
  load_balancer_arn = aws_lb.public.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

resource "aws_lb" "private" {
  name               = "terraform-3tier-private-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.private_alb_sg_id]
  subnets            = slice(var.private_subnet_ids, 2, 4)

  tags = {
    Name = "terraform-3tier-private-alb"
  }
}

resource "aws_lb_target_group" "app" {
  name     = "terraform-3tier-app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "private" {
  load_balancer_arn = aws_lb.private.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}
