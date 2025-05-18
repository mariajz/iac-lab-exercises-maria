output "vpc_id" {
  description = "The ID of the main VPC"
  value       = module.vpc.vpc_id
}

output "ecr_url" {
  description = "ECR URL"
  value       = module.ecs.ecr_url
}

output "website_url" {
  description = "The website URL."
  value       = format("http://%s/users", aws_lb.lb.dns_name)
}
