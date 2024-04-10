resource "aws_iam_policy" "this" {
  name        = "${var.task_name}-ECRPolicy"
  description = "IAM policy for ECS tasks to interact with ECR"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role" "this" {
  name = "${var.task_name}-ecsTaskExecutionRole"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ecs-tasks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecr_policy_attachment" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}

