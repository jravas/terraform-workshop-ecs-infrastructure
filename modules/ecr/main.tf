resource "aws_ecr_repository" "this" {
  name                 = var.name
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.this.name

  policy = jsonencode({
    rules = [
      # TODO: Add more rules after CI/CD and image tagging is implemented
      {
        action = {
          type = "expire"
        },
        selection = {
          countType   = "imageCountMoreThan",
          countNumber = 10,
          tagStatus   = "untagged",
        },
        description  = "Remove PR images",
        rulePriority = 1
      }
    ]
  })
}
