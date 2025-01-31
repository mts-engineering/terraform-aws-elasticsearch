locals {
  output_domain = var.prevent_destroy ? aws_elasticsearch_domain.safe_es_domain : aws_elasticsearch_domain.es_domain
}

output "arn" {
  description = "Amazon Resource Name (ARN) of the domain"
  value       = join("", local.output_domain.*.arn)
}

output "domain_id" {
  description = "Unique identifier for the domain"
  value       = join("", local.output_domain.*.domain_id)
}

output "endpoint" {
  description = "Domain-specific endpoint used to submit index, search, and data upload requests"
  value       = join("", local.output_domain.*.endpoint)
}

output "kibana_endpoint" {
  description = "Domain-specific endpoint for kibana without https scheme"
  value       = join("", local.output_domain.*.kibana_endpoint)
}

output "master_username" {
  description = "Master username"
  value       = local.master_user_name
}

output "master_password" {
  description = "Master password"
  value       = local.master_user_password
  sensitive   = true
}

output "vpc_options_availability_zones" {
  description = "If the domain was created inside a VPC, the names of the availability zones the configured subnet_ids were created inside"
  value       = var.enabled ? (length(local.output_domain[0].vpc_options) > 0 ? local.output_domain[0].vpc_options.0.availability_zones : []) : []
}

output "vpc_options_vpc_id" {
  description = "If the domain was created inside a VPC, the ID of the VPC"
  value       = var.enabled ? length(local.output_domain[0].vpc_options) > 0 ? local.output_domain[0].vpc_options.0.vpc_id : null : null
}
