module "vpc" {
    source = "../vpc"
}

resource "aws_security_group" "practice_sg" {
    name = "ec2-instance-sg"
    description = "Security group for EC2 instance"
    vpc_id = var.network.vpc_id
}

resource "aws_security_group" "rds_security_group" {
    name = "rds-instance-sg"
    description = "Security group for RDS instance"
    vpc_id = var.network.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "practice_sg_ingress" {
    security_group_id = aws_security_group.practice_sg.id
    cidr_ipv4 = "{your_ip_address}/32" // My IP address
    from_port = 22
    ip_protocol = "tcp"
    to_port = 22
}

resource "aws_vpc_security_group_ingress_rule" "practice_sg_ingress_http" {
    security_group_id = aws_security_group.practice_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 80
    ip_protocol = "tcp"
    to_port = 80
}

resource "aws_vpc_security_group_egress_rule" "practice_sg_egress_ipv4" {
    security_group_id = aws_security_group.practice_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1" // semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "practice_sg_egress_ipv6" {
    security_group_id = aws_security_group.practice_sg.id
    cidr_ipv6 = "::/0"
    ip_protocol = "-1" // semantically equivalent to all ports
}

// Allow inbound MySQL traffic from EC2 instance security group to RDS instance security group
resource "aws_vpc_security_group_ingress_rule" "rds_security_group_ingress" {
    security_group_id = aws_security_group.rds_security_group.id
    referenced_security_group_id = aws_security_group.practice_sg.id
    from_port = 3306
    ip_protocol = "tcp"
    to_port = 3306
}

resource "aws_security_group" "ecs_security_group" {
    name = "ecs_security_group"
    description = "Security group for ECS tasks"
    vpc_id = var.network.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "ecs_sg_egress_ipv4" {
    security_group_id = aws_security_group.ecs_security_group.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1" // semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "ecs_sg_egress_ipv6" {
    security_group_id = aws_security_group.ecs_security_group.id
    cidr_ipv6 = "::/0"
    ip_protocol = "-1" // semantically equivalent to all ports
}

// Allow inbound traffic from ECS tasks to RDS instance security group
resource "aws_vpc_security_group_ingress_rule" "rds_security_group_ingress_from_ecs" {
    security_group_id = aws_security_group.rds_security_group.id
    referenced_security_group_id = aws_security_group.ecs_security_group.id
    from_port = 3306
    ip_protocol = "tcp"
    to_port = 3306
}

