output "ecs_resources" {
    value = {
        ecr_repository_name = aws_ecr_repository.practice_ecr_repository.name
        ecr_repository_arn = aws_ecr_repository.practice_ecr_repository.arn
        ecs_cluster_name = aws_ecs_cluster.practice_ecs_cluster.name
    }
}