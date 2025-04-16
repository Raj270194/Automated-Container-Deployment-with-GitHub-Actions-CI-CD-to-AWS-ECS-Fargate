output "alb_dns" {
  description = "DNS name of the ALB"
  value       = aws_lb.app_lb.dns_name
}


output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_1" {
  value = aws_subnet.public_1.id
}

output "public_subnet_2" {
  value = aws_subnet.public_2.id
}
