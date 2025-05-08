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

variable "subnet1_cidr" {
  type        = string
  description = "CIDR block for public subnet AZ1"
}

variable "subnet2_cidr" {
  type        = string
  description = "CIDR block for private subnet AZ1"
}

variable "subnet3_cidr" {
  type        = string
  description = "CIDR block for secure subnet AZ1"
}

variable "subnet4_cidr" {
  type        = string
  description = "CIDR block for public subnet AZ2"
}

variable "subnet5_cidr" {
  type        = string
  description = "CIDR block for private subnet AZ2"
}

variable "subnet6_cidr" {
  type        = string
  description = "CIDR block for secure subnet AZ2"
}

