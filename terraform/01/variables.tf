variable "region" {
  type        = string
  description = "region for provider"
}

variable "aws_profile" {
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