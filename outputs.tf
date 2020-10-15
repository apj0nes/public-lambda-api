output "r53_dns" {
  value = "${aws_route53_record.r53.name}"
}

output "iam_role" {
  value = "${aws_iam_role.lambda_role.name}"
}