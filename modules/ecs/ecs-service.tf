resource "aws_ecs_service" "practice_ecs_service" {
    name = "practice_ecs_service"
    cluster = aws_ecs_cluster.practice_ecs_cluster.id
    task_definition = aws_ecs_task_definition.practice_task_definition.arn
    desired_count = 1
    launch_type = "FARGATE"
    enable_execute_command = true

    network_configuration {
        subnets         = [
            var.network.private_subnets.private_subnet_1_id,
            var.network.private_subnets.private_subnet_2_id
        ]
        security_groups = [var.ec2_resources.security_groups.ecs_security_group_id]
        assign_public_ip = false
    }
}