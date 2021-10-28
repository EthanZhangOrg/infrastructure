data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = [var.ami_owner_id]
}

resource "aws_key_pair" "ssh_key" {
  key_name   = var.ssh_key_name
  public_key = var.ssh_key_public_key
}

resource "aws_instance" "webapp" {
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = var.webapp_instance_type
  disable_api_termination = var.webapp_disable_api_termination
  subnet_id               = aws_subnet.subnet[keys(aws_subnet.subnet)[0]].id

  root_block_device {
    volume_size = var.webapp_root_volume_size
    volume_type = var.webapp_root_volume_type
  }

  key_name = aws_key_pair.ssh_key.key_name

  vpc_security_group_ids = [aws_security_group.application.id]

  iam_instance_profile = aws_iam_instance_profile.iam_instance_profile.name

  depends_on = [aws_db_instance.db_instance]

  user_data = <<EOF
#!/bin/bash

####################################################
# Configure Webapp Properties                      #
####################################################
cd /home/ubuntu
mkdir webapp_jar
cd webapp_jar
touch application.properties
echo "spring.datasource.url=jdbc:mysql://${aws_db_instance.db_instance.endpoint}/csye6225" >> application.properties
echo "spring.datasource.username=${aws_db_instance.db_instance.username}" >> application.properties
echo "spring.datasource.password=${aws_db_instance.db_instance.password}" >> application.properties
echo "spring.jpa.hibernate.ddl-auto=update" >> application.properties
echo "cloud.aws.region=${var.region}" >> application.properties
echo "s3.bucket.name=${aws_s3_bucket.s3_bucket.bucket}" >> application.properties
chown ubuntu:ubuntu application.properties
cd ..
chown ubuntu:ubuntu webapp_jar
  EOF

  tags = {
    Name = var.webapp_name
  }
}