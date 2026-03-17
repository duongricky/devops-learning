resource "aws_ecs_cluster" "practice_ecs_cluster" {
    name = "practice_ecs_cluster"

    setting {
        name  = "containerInsights"
        value = "enabled"
    }
}