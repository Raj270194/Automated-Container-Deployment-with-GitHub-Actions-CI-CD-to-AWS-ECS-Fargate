resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Create the IAM Policy for CloudWatch Log Group Management
resource "aws_iam_policy" "cloudwatch_log_group_policy" {
  name        = "AllowCloudWatchLogGroupManagement"
  description = "Allows creation, retention config, and tagging of CloudWatch log groups"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "logs:CreateLogGroup",
          "logs:PutRetentionPolicy",
          "logs:TagResource"
        ]
        Resource = "*"
      }
    ]
  })
}

# Attach the Policy to terraform-user
resource "aws_iam_user_policy_attachment" "terraform_user_log_policy" {
  user       = "terraform-user"  
  policy_arn = aws_iam_policy.cloudwatch_log_group_policy.arn
}
