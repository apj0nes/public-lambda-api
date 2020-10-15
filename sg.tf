resource "aws_security_group" "alb_sg" {
  name = "${module.naming.aws_security_group}-lb"
  vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"
  tags = "${var.tags}"
}

resource "aws_security_group_rule" "alb_ingress_fastly" {
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["${data.fastly_ip_ranges.fastly.cidr_blocks}"]
  ipv6_cidr_blocks = ["${data.fastly_ip_ranges.fastly.ipv6_cidr_blocks}"]
  security_group_id = "${aws_security_group.alb_sg.id}"
}