resource "aws_ecr_repository" "practice_ecr_repository" {
  name                 = "practice_ecr_repository"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
