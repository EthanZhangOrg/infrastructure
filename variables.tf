variable "region" {
  type        = string
  description = "region for provider"
}

variable "aws_profile" {
  type        = string
  description = ""
}

variable "aws_account_id" {
  type        = string
  description = ""
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR for VPC"
}

variable "subnet_az_cidr" {
  type        = map(any)
  description = "subnets avalability and cidr"
}

variable "internet_ipv4" {
  type        = string
  description = ""
}

variable "enable_dns_hostnames" {
  type        = bool
  description = ""
}

variable "enable_dns_support" {
  type        = bool
  description = ""
}

variable "enable_classiclink_dns_support" {
  type        = bool
  description = ""
}

variable "assign_generated_ipv6_cidr_block" {
  type        = bool
  description = ""
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = ""
}

variable "vpc_name" {
  type        = string
  description = "name for vpc"
}

variable "subnet_name" {
  type        = string
  description = "name for subnets"
}

variable "gateway_name" {
  type        = string
  description = "name for gateway"
}

variable "route_table_name" {
  type        = string
  description = "name for route table"
}

// variables for security groups
variable "application_security_group_name" {
  type        = string
  description = ""
}

variable "application_security_group_description" {
  type        = string
  description = ""
}

variable "database_security_group_name" {
  type        = string
  description = ""
}

variable "database_security_group_description" {
  type        = string
  description = ""
}

// variables for s3 bucket
variable "s3_bucket_acl" {
  type        = string
  description = ""
}

variable "s3_bucket_force_destroy" {
  type        = bool
  description = ""
}

// variables for RDS Parameter Group
variable "db_parameter_group_name" {
  type        = string
  description = ""
}

variable "db_parameter_group_family" {
  type        = string
  description = ""
}

// variables for RDS Instance
variable "db_subnet_group_name" {
  type        = string
  description = ""
}

variable "db_instance_allocated_storage" {
  type        = number
  description = ""
}

variable "db_instance_engine" {
  type        = string
  description = ""
}

variable "db_instance_engine_version" {
  type        = string
  description = ""
}

variable "db_instance_instance_class" {
  type        = string
  description = ""
}

variable "db_instance_multi_az" {
  type        = bool
  description = ""
}

variable "db_instance_identifier" {
  type        = string
  description = ""
}

variable "db_instance_username" {
  type        = string
  description = ""
}

variable "db_instance_password" {
  type        = string
  description = ""
}

variable "db_instance_publicly_accessible" {
  type        = bool
  description = ""
}

variable "db_instance_skip_final_snapshot" {
  type        = bool
  description = ""
}

variable "db_instance_name" {
  type        = string
  description = ""
}


// variables for ec2 Instance
variable "ami_owner_id" {
  type        = string
  description = ""
}

variable "ssh_key_name" {
  type        = string
  description = ""
}

variable "ssh_key_public_key" {
  type        = string
  description = ""
}

variable "webapp_instance_type" {
  type        = string
  description = ""
}

variable "webapp_disable_api_termination" {
  type        = bool
  description = ""
}

variable "webapp_root_volume_size" {
  type        = number
  description = ""
}

variable "webapp_root_volume_type" {
  type        = string
  description = ""
}

variable "webapp_name" {
  type        = string
  description = ""
}

// variables for IAM policy and role
variable "iam_policy_name" {
  type        = string
  description = ""
}

variable "iam_role_name" {
  type        = string
  description = ""
}

variable "iam_policy_attachment_name" {
  type        = string
  description = ""
}

variable "iam_instance_profile_name" {
  type        = string
  description = ""
}

// variables for codedeploy roles and policies
variable "iam_user_name" {
  type        = string
  description = ""
}

// variables for codedeploy application and deployment groups
variable "compute_platform" {
  type        = string
  description = ""
}

variable "deployment_type" {
  type        = string
  description = ""
}

variable "deployment_config_name" {
  type        = string
  description = ""
}

// variables for route 53
variable "route53_record_name" {
  type        = string
  description = ""
}

variable "route53_record_zone_id" {
  type        = string
  description = ""
}

variable "route53_record_type" {
  type        = string
  description = ""
}

variable "route53_record_ttl" {
  type        = string
  description = ""
}

variable "aws_eip_vpc" {
  type        = bool
  description = ""
}
