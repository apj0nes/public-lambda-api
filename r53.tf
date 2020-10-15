resource "aws_route53_record" "r53" {
  zone_id = "${module.zone.public_zone_id}"
  name = "${var.application_name}.${module.zone.public_zone}"
  type = "A"

  alias {
    name = "${lower(aws_lb.app.dns_name)}"
    zone_id = "${aws_lb.app.zone_id}"
    evaluate_target_health = false
  }

  lifecycle {
    create_before_destroy = true
  }
}