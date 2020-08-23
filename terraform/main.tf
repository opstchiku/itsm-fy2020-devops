terraform {
  required_version = "~> 0.13"
}

provider "aws" {
    region = "ap-northeast-1"
}

# ====================
# VPC
# ====================
resource "aws_vpc" "example" {
    cidr_block           = "10.0.0.0/16"
    enable_dns_support   = true
    enable_dns_hostnames = true
    tags = {
        Name = "example"
    }
}

# ====================
# Subnet
# ====================
resource "aws_subnet" "example" {
    cidr_block        = "10.0.1.0/24"
    availability_zone = "ap-northeast-1a"
    vpc_id            = aws_vpc.example.id
    map_public_ip_on_launch = true
    tags = {
        Name = "example"
    }
}

# ====================
# Internet Gateway
# ====================
resource "aws_internet_gateway" "example" {
    vpc_id = aws_vpc.example.id
    tags = {
        Name = "example"
    }
}

# ====================
# Route Table
# ====================
resource "aws_route_table" "example" {
    vpc_id = aws_vpc.example.id
    tags = {
        Name = "example"
    }
}

resource "aws_route" "example" {
    gateway_id             = aws_internet_gateway.example.id
    route_table_id         = aws_route_table.example.id
    destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "example" {
    subnet_id      = aws_subnet.example.id
    route_table_id = aws_route_table.example.id
}

# ====================
# Security Group
# ====================
resource "aws_security_group" "example" {
    vpc_id = aws_vpc.example.id
    name   = "example"
    tags = {
        Name = "example"
    }
}

# インバウンドルール(ssh接続用)
resource "aws_security_group_rule" "in_ssh" {
    security_group_id = aws_security_group.example.id
    type              = "ingress"
    cidr_blocks       = ["0.0.0.0/0"]
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
}

# インバウンドルール(pingコマンド用)
resource "aws_security_group_rule" "in_icmp" {
    security_group_id = aws_security_group.example.id
    type              = "ingress"
    cidr_blocks       = ["0.0.0.0/0"]
    from_port         = -1
    to_port           = -1
    protocol          = "icmp"
}

# アウトバウンドルール(全開放)
resource "aws_security_group_rule" "out_all" {
    security_group_id = aws_security_group.example.id
    type              = "egress"
    cidr_blocks       = ["0.0.0.0/0"]
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
}

# ====================
# EC2 Instance
# ====================
resource "aws_instance" "webserver" {
    ami = "ami-0cc75a8978fbbc969"
    vpc_security_group_ids = [aws_security_group.example.id]
    subnet_id              = aws_subnet.example.id
    instance_type = "t2.micro"
    key_name = var.key_name
    tags = {
        Name = var.webserver_instance_name
    }
}

resource "aws_instance" "monitoring" {
    ami = "ami-0cc75a8978fbbc969"
    vpc_security_group_ids = [aws_security_group.example.id]
    subnet_id              = aws_subnet.example.id
    instance_type = "t2.micro"
    key_name = var.key_name
    tags = {
        Name = var.monitoring_instance_name
    }
}

resource "aws_instance" "jenkins" {
    ami = "ami-0cc75a8978fbbc969"
    vpc_security_group_ids = [aws_security_group.example.id]
    subnet_id              = aws_subnet.example.id
    instance_type = "t2.micro"
    key_name = var.key_name
    tags = {
        Name = var.jenkins_instance_name
    }
}

# ====================
# Key Pair
# ====================
resource "aws_key_pair" "my_aws_key" {
    key_name   = var.key_name
    public_key = file(var.public_key)
}

# ====================
# Elastic IP
# ====================
# resource "aws_eip" "example" {
#     instance = aws_instance.example.id
#     vpc      = true
# }

# ====================
# Ansible
# ====================
# resource "local_file" "hosts_file" {
#   content         = <<EOF
# [webservers]
# ${aws_instance.webserver.public_dns}

# [monitoring]
# ${aws_instance.monitoring.public_dns}
# EOF
#   filename        = "ansible/hosts"
#   file_permission = "0644"
# }
