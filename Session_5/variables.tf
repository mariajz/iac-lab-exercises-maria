variable "prefix" {
  type        = string
  description = "name prefix"
}

variable "region" {
  type        = string
  description = "AWS region to deploy resources"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
}
