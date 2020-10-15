resource "aws_lb" "app" {
  name = "${module.naming.aws_alb}app"
  load_balancer_type = "application"
  subnets = ["${data.terraform_remote_state.vpc.subnets_lb_public}"]

  security_groups = [
    "${data.terraform_remote_state.vpc.sg_lb_common}",
    "${aws_security_group.alb_sg.id}",
  ]

  enable_cross_zone_load_balancing = true
  idle_timeout = 60

  tags = "${var.tags}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "app_alb_listener"{
  load_balancer_arn = "${aws_lb.app.arn}"
  port = 443
  protocol = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  certificate_arn = "${data.aws_acm_certificate.ssl_certificate.arn}"

  default_action {
    type = "forward"
    target_group_arn = "${aws_lb_target_group.alb_tg.arn}"
  }
}

resource "aws_lb_target_group" "alb_tg" {
  name = "${module.naming.aws_alb}app-tg"
  target_type = "lambda"

  port = "${var.application_port}"
  protocol = "HTTP"
  vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"

  tags = "${var.tags}"
}

resource "aws_lb_target_group_attachment" "alb_tg_att" {
  target_group_arn = "${aws_alb_target_group.alb_tg.arn}"
  target_id = "${aws_lambda_function.lambda_api.arn}"
  depends_on = ["aws_lambda_permission.allow_alb_to_invoke_lambda"]
}