resource "aws_ecs_cluster" "java_cluster" {
  name = "java-app-cluster"

  tags = {
    Name = "java-app-cluster"
  }
}

resource "aws_ecs_task_definition" "java_app" {
  family                   = "java-ecs-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "java-app"
      image     = var.ecr_image_url
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/java-app"
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  tags = {
    Name = "java-app-task"
  }
}

resource "aws_ecs_service" "java_app_service" {
  name            = "java-app-service"
  cluster         = aws_ecs_cluster.java_cluster.id
  launch_type     = "FARGATE"
  desired_count   = 2
  task_definition = aws_ecs_task_definition.java_app.arn
  platform_version = "LATEST"

  network_configuration {
    subnets         = [aws_subnet.private_1.id, aws_subnet.private_2.id]
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.app_tg.arn
    container_name   = "java-app"
    container_port   = 8080
  }

  depends_on = [aws_lb_listener.http_listener]

  tags = {
    Name = "java-app-service"
  }
}
