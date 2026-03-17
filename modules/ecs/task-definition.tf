resource "aws_ecs_task_definition" "practice_task_definition" {
    family                   = "practice_task_definition"
    network_mode             = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    cpu                      = "256"
    memory                   = "512"

    execution_role_arn       = var.iam_role.ecs_task_execution_role_arn
    task_role_arn            = var.iam_role.ecs_task_role_arn

    container_definitions = jsonencode([
        {
            name      = "php-app"
            image     = "${aws_ecr_repository.practice_ecr_repository.repository_url}:latest"
            essential = true
            portMappings = [
                {
                    containerPort = 80
                    hostPort      = 80
                    protocol      = "tcp"
                }
            ]

            environment = [
                {
                    name  = "APP_ENV"
                    value = "local"
                },
            ]
        }
    ])
}