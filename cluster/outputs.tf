output "vpc_arn" {
  value = aws_vpc.this.arn
}

output "internet_gateway_arn" {
  value = aws_internet_gateway.this.arn
}

output "nat_gateway_id" {
  value = aws_nat_gateway.this.id
}

output "public_subnets" {
  value = aws_subnet.publics[*].id
}

output "private_subnets" {
  value = aws_subnet.publics[*].id
}
