resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/java-app"
  retention_in_days = 7

  tags = {
    Name = "ecs-java-log-group"
  }
}
