data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = [var.ami_owner_id]
}

resource "aws_key_pair" "ssh_key" {
  key_name   = var.ssh_key_name
  public_key = var.ssh_key_public_key
}