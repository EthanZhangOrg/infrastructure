variable "vpc_cidr_block" {
  type        = string
  description = "CIDR for VPC"
  // default = "0.0.0.0/16"
}

variable "aws_profile" {
  type        = string
  description = ""
}

variable "subnet_az_cidr" {
  type        = map(any)
  description = ""
}

variable "internet_ipv4" {
  type        = string
  description = ""
  // default = "0.0.0.0/0"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = ""
  default     = true
}

variable "enable_dns_support" {
  type        = bool
  description = ""
  default     = true
}

variable "enable_classiclink_dns_support" {
  type        = bool
  description = ""
  default     = true
}

variable "assign_generated_ipv6_cidr_block" {
  type        = bool
  description = ""
  default     = false
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = ""
  default     = true
}

variable "vpc_name" {
  type        = string
  description = ""
}

variable "subnet_name" {
  type        = string
  description = ""
}

variable "gateway_name" {
  type        = string
  description = ""
}

variable "route_table_name" {
  type        = string
  description = ""
}