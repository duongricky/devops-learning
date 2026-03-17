output "ec2_resources" {
  value = {
    security_groups = {
      ecs_security_group_id = aws_security_group.ecs_security_group.id
      rds_security_group_id = aws_security_group.rds_security_group.id
    }
  }
}
