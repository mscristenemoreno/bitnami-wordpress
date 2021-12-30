variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "username" {}
variable "password" {}
variable "key_name" {}
variable "private_key" {}

variable "aws_region" {}
variable "network_address_space" {}
variable "instance_size" {}
variable "instance_count" {
  default = 1
}

variable "subnet_count" {
  default = 2
}

variable "environment_tag" {}


