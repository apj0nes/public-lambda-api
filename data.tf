data "terraform_remote_state" "vpc" {
  backend = "s3"

  config {
    bucket = "${var.terraformer_bucket}"
    key = "${var.vpc_remote_state_key}"
    region = "${var.aws_region}"
  }
}

data "aws_acm_certificate" "ssl_certificate" {
  domain = "${var.ssl_domain_name}"
  statuses = ["ISSUED"]
}

data "fastly_ip_ranges" "fastly" {}