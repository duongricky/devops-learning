resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [
    var.network.private_subnets.private_subnet_1_id,
    var.network.private_subnets.private_subnet_2_id
  ]
}

resource "aws_db_instance" "rds_instance" {
  identifier = "php-db-demo"
  engine = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"
  allocated_storage = 20
  username = "admin"
  password = "dbpassword"
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [
    var.ec2_resources.security_groups.rds_security_group_id
  ]
  publicly_accessible = false
  skip_final_snapshot = true
}