resource "aws_ecr_repository" "images" {
  count = length(var.ecr_repositories)

  name                 = var.ecr_repositories[count.index].name
  image_tag_mutability = var.ecr_repositories[count.index].image_tag_mutability

  tags = var.tags
}