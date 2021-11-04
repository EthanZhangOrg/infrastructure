aws_profile    = "prod"
internet_ipv4  = "0.0.0.0/0"
region         = "us-east-1"
aws_account_id = "039848784614"

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

// parameters for security groups
application_security_group_name        = "application"
application_security_group_description = "application security group for csye6225"
database_security_group_name           = "database"
database_security_group_description    = "database security group for csye6225"

// parameters for s3 bucket
s3_bucket_acl           = "private"
s3_bucket_force_destroy = true

// parameters for RDS Parameter Group
db_parameter_group_name   = "rds-pg-mysql"
db_parameter_group_family = "mysql8.0"

// parameters for RDS Instance
db_subnet_group_name            = "rds-subnet-group"
db_instance_allocated_storage   = 10
db_instance_engine              = "mysql"
db_instance_engine_version      = "8.0.11"
db_instance_instance_class      = "db.t3.micro"
db_instance_multi_az            = false
db_instance_identifier          = "csye6225"
db_instance_username            = "csye6225"
db_instance_password            = "ra9ra9ra9"
db_instance_publicly_accessible = false
db_instance_skip_final_snapshot = true
db_instance_name                = "csye6225"

// parameters for ec2 Instance
ami_owner_id                   = "843512289407"
ssh_key_name                   = "ssh-key"
ssh_key_public_key             = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCrJpxQyAJ/XHxyVtoz1DyxvLmu4FwQANI5s8thFdt99e1SQfAJH38btdmNSywNyDa294vIuKCBu+Uo1N4qoHRFOUoNWxeF3P4bP590s/wQVIQdiasPMBMRl2uyUbHOAv/NFrrTcVt+SE8zmKsudOf2rBokjdXUSXDI665NYYGyFBNXafGf6WPNvcU1gYzZ8M5DZRk09qZIJH1gcMiVNiV1IPRpRzDii28drXdCT0c3YqZ473xDlC9Nvm5jgAGpXrG1tKDcyAbOZuf3sMQ1i5T93aygfjKF1m3Uot3QmFURnP54MvePHALzv4fouqsoNCBePj/wNDWx+teY9G0+g41Z/OoMD1n0YCcJISYqn0VddzDikABnJOe73hpJ+rc/6rMkDjN73sS7htMfAggNDKjVYA/TBdjteGTl+WEyYf1CsVMtbRBqzPVerpWboCeLZidR6HHlacgYDA5pDe2XTK80gCCO2GOauv6sbxGIbNZID4mkk1cLFuEPJPEZIxkMULk= zhang.tianqi1@northeastern.com"
webapp_instance_type           = "t2.micro"
webapp_disable_api_termination = false
webapp_root_volume_size        = 20
webapp_root_volume_type        = "gp2"
webapp_name                    = "csye6225-ec2-instance-fall2021-a5-prod"

// parameters for IAM policy and role
iam_policy_name            = "WebAppS3"
iam_role_name              = "EC2-CSYE6225"
iam_policy_attachment_name = "WebAppS3-iam-policy-attachment"
iam_instance_profile_name  = "csye6225-iam-instance-profile"
iam_user_name              = "ghactions-app"

// parameters for codedeploy roles and policies
compute_platform       = "Server"
deployment_type        = "IN_PLACE"
deployment_config_name = "CodeDeployDefault.AllAtOnce"

// variables for route 53
route53_record_name    = "prod.ethanzhang1997.me"
route53_record_zone_id = "Z103566016ELASG8LQ3JK"
route53_record_type    = "A"
route53_record_ttl     = "300"
aws_eip_vpc            = true
