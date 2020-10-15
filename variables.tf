variable "tags" {
  type = "map"
}

variable "application_environment_variables" {
  type = "map"
  default = {}
}

variable "terraformer_bucket"{}

variable "vpc_remote_state_key" {}

variable "lambda_build_folder" {}

variable "application_name" {}

variable "lambda_runtime"{
  default = "ruby2.7"
}

variable "lambda_memory" {
    default = "256"
}

variable "aws_region"{
  default = "eu-west-1"
}

variable "application_port" {
  default = 3000
}