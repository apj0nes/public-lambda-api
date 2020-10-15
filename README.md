# public-api-lambda

Terraform module that enables the provisioning of a load balanced, public api hosted using AWS Lambda.

This module will output a route53 DNS name that should be used as a target to route traffic to from Fastly. This is by design as it forces all public traffic through the Fastly service which provides edge caching, cross region (eu-west-1, eu-central-1,...)load balancing, web application firewall, ddos protection and a host of other features.

The module is language agnostic, provided AWS Lambda has the runtime, any application should be able to be deployed.

For a list of assumptions and dependencies please see https://github.com/apj0nes/rails-example#assumptions

## Usage

An example repository consuming the module can be seen here https://github.com/apj0nes/rails-example

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| tags | Resource tags | string | - | yes |
| application_environment_variables | Environment variables set in the lambda | map | - | no |
| terraformer_bucket | S3 bucket holding the remote state | string | - | yes |
| vpc_remote_state_key | Key used to lookup the remote state within the S3 bucket | string | - | yes |
| lambda_build_folder | The directory to source the lambda function code from | string | - | yes |
| application_name | The name of the application | string | - | yes |
| lambda_runtime | The lambda runtime | string | `ruby2.7` | no |
| lambda_memory | The lambda memory | string | `256` | no |
| aws_region | The AWS region to deploy to | string | `eu-west-1` | no |
| application_port | The port the application is served on | string | `3000` | no |

## Outputs

| Name | Description |
|------|-------------|
| r53_dns | The route 53 alias which must be configured in Fastly |
| iam_role | IAM Role name, usful to add additional policy attachments |