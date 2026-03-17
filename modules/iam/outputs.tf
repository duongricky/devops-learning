output "iam_role" {
    value = {
        ec2_role_name = aws_iam_role.ec2_instance_role.name
        ec2_role_arn = aws_iam_role.ec2_instance_role.arn
        ec2_instance_profile_name = aws_iam_instance_profile.practice_ec2_profile.name
        ecs_task_execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
        ecs_task_role_arn = aws_iam_role.ecs_task_role.arn
    }
}