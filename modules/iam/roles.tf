data "aws_iam_policy_document" "ecs_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "ec2_instance_role" {
  name        = "ec2_instance_role"
  description = "IAM role for EC2 instances to access AWS services"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  // Allow EC2 instances with this role to access the S3 bucket created in this practice
  inline_policy {
    name = "allow_access_to_s3"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Action = [
            "s3:*",
          ]
          Resource = [
            "${var.s3_bucket.bucket_arn}/*"
          ]
        }
      ]
    })
  }

  inline_policy {
    name = "allow_list_s3_buckets"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Action = [
            "s3:ListBucket",
          ]
          Resource = [
            "${var.s3_bucket.bucket_arn}"
          ]
        }
      ]
    })
  }
}

resource "aws_iam_instance_profile" "practice_ec2_profile" {
  name = "practice-ec2-profile"
  role = aws_iam_role.ec2_instance_role.name
}

data "aws_iam_policy_document" "ecs_task_role_policy_document" {
  statement {
    sid    = "AllowListS3Buckets"
    effect = "Allow"
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      "${var.s3_bucket.bucket_arn}"
    ]
  }

  statement {
    sid    = "AllowAccessToS3"
    effect = "Allow"
    actions = [
      "s3:*",
    ]
    resources = [
      "${var.s3_bucket.bucket_arn}/*"
    ]
  }

  statement {
    sid    = "AllowCreateChannelForEcsExec"
    effect = "Allow"
    actions = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "ecs_task_execution_role_policy_document" {
  statement {
    sid    = "AllowAuthToEcr"
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowGetEcrImages"
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage"
    ]
    resources = [
      "${var.ecs_resources.ecr_repository_arn}",
    ]
  }
}

resource "aws_iam_role" "ecs_task_role" {
  name               = "ecs_task_role"
  description        = "IAM role for ECS tasks to access AWS services"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role.json
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "ecs_task_execution_role"
  description        = "IAM role for ECS tasks to access AWS services during execution"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role.json
}

resource "aws_iam_role_policy" "ecs_task_role_policy" {
  role        = aws_iam_role.ecs_task_role.name
  name_prefix = "ecs_task_role_policy"
  policy      = data.aws_iam_policy_document.ecs_task_role_policy_document.json
}

resource "aws_iam_role_policy" "ecs_task_execution_role_policy" {
  role        = aws_iam_role.ecs_task_execution_role.name
  name_prefix = "ecs_task_execution_role_policy"
  policy      = data.aws_iam_policy_document.ecs_task_execution_role_policy_document.json
}
