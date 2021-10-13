aws_profile   = "prod"
internet_ipv4 = "0.0.0.0/0"
region  = "us-east-1"

// vpc_cidr_block
vpc_cidr_block = "10.0.0.0/16"

// vpc arguments 
enable_dns_hostnames             = true
enable_dns_support               = true
enable_classiclink_dns_support   = true
assign_generated_ipv6_cidr_block = false

// subnet_az_cidr
subnet_az_cidr = {
  "us-east-1a" = "10.0.2.0/24",
  "us-east-1b" = "10.0.3.0/24",
  "us-east-1c" = "10.0.4.0/24",
}

// subnet arguments
map_public_ip_on_launch = true

// names
vpc_name         = "csye6225-vpc-fall2021-1"
subnet_name      = "csye6225-subnet-fall2021-1"
gateway_name     = "csye6225-Internet-gateway-fall2021-1"
route_table_name = "csye6225-route-table-fall2021-1"