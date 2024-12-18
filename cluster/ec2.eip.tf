resource "aws_eip" "this" {
  domain = "vpc"

  tags = merge(var.tags, {
    Name = var.vpc.nat_gateway_public_ip_name
  })
}
