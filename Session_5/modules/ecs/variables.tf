variable "prefix" {
  type        = string
  description = "name prefix"
}

variable "region" {
  type        = string
  description = "AWS region to deploy resources"
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs to use for ECS tasks"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC id"
  type        = string
}

variable "alb_target_group_arn" {
  description = "The ARN of the ALB target group"
  type        = string
}

variable "alb_security_group_id" {
  description = "The id of the ALB security group"
  type        = string
}

variable "db_address" {
  description = "The ARN of the ALB target group"
  type        = string
}

variable "db_name" {
  description = "db name"
  type        = string
}

variable "db_username" {
  description = "db username"
  type        = string
}

variable "db_secret_arn" {
  description = "db secret arn"
  type        = string
}

variable "db_secret_key_id" {
  description = "db secret key id"
  type        = string
}

