## Automated Container Deployment with GitHub Actions CI/CD to AWS ECS Fargate 

![image_alt](https://github.com/Tatenda-Prince/Automated-Container-Deployment-with-GitHub-Actions-CI-CD-to-AWS-ECS-Fargate/blob/6c876d1ee4eb62be764791816462881a4502bae9/screenshots/Screenshot%202025-04-18%20102451.png)

## Background
As part of my cloud and DevOps engineering journey, I wanted to build a real-world CI/CD pipeline that showcases my ability to:

1.Provision infrastructure as code using **Terraform**

2.Set up a secure, scalable container deployment using **AWS ECS Fargate**

3.Automate testing and deployment using **GitHub Actions**

This project demonstrates a production-ready deployment pipeline for a Java application using modern DevOps practices and tools.

## Project Overview
This project contains a complete CI/CD pipeline for a containerized Java application. It includes:
1.Infrastructure provisioning with Terraform

2.Java app packaged with Docker

3.CI/CD using GitHub Actions

4.Deployment to AWS ECS Fargate

5.Logging with Amazon CloudWatch

6.Load balancing with ALB

7.Private/public subnet isolation

8.Store docker images with ECR

## Project Objectives
1.Automate infrastructure provisioning using Terraform

2.Deploy Java app container to AWS ECS Fargate

3.Ensure zero-downtime deployments with ECS service updates

4.Implement CI/CD with GitHub Actions

5.Apply secure secret management using GitHub Secrets

6.Store logs in Amazon CloudWatch for observability

##  Features
1.Fully automated CI/CD pipeline with GitHub Actions

2.Build and test Java application on every commit

3.Push Docker images to Amazon ECR

4.Deploy to ECS Fargate with zero manual steps

5.Logs accessible in CloudWatch

6.Highly available architecture with ALB & VPC isolation


## Technologies Used
1.AWS ECS Fargate- Serverless container hosting  

2.Amazon ECR- Docker image registry   

3.GitHub Actions- CI/CD automation  

4.Terraform- Infrastructure as Code 

5.CloudWatch Logs- Logging and observability 

6.Docker- Containerization  

7.ALB, VPC, Subnets- Networking and Load Balancing   

8.Java (Spring Boot)- Backend Application                  


##  Use Case
You work as Devops Engineer at Up the Chels Corp and run a cloud-based Java microservice that needs automatic deployment to a scalable, fault-tolerant infrastructure. Perfect for **startups**, **enterprise microservices**, or **DevOps learning labs**.

## Prerequisites
1.AWS Account with admin permissions

2.[AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) configured (`aws configure`)

3.Terraform installed

4.Docker installed

5.GitHub repository with secrets:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
  - `ECR_URI`
  - `TASK_FAMILY`
  - `ECS_CLUSTER_NAME`
  - `ECS_SERVICE_NAME`

## Step 0: Clone the Repository
Clone this repository to your local machine.
```language
git clone https://github.com/Tatenda-Prince/Automated-Container-Deployment-with-GitHub-Actions-CI-CD-to-AWS-ECS-Fargate.git
```

## Step 1: Create a ECR Repository 
1.1.Before Terraform provisons AWS resources we need to push your application Docker image to ECR, so we need to build and push docker images to Amazon ECR:
```language
aws ecr create-repository --repository-name your-repository-name

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <YOUR ACCOUNT ID>.dkr.ecr.us-east-1.amazonaws.com

docker build -t my-java-app .

docker tag my-node-app:latest <ECR_URI>:latest

docker push <ECR_URI>:latest
```

![image_alt](https://github.com/Tatenda-Prince/Automated-Container-Deployment-with-GitHub-Actions-CI-CD-to-AWS-ECS-Fargate/blob/6748470f21a3d9db096b803909dd409b4ce1b868/screenshots/Screenshot%202025-04-16%20203239.png)

## Step 2 : Run Terraform workflow to initialize, validate, plan then apply
2.1.Terraform will provision:

1.ECS Cluster, Task Definition, and Service

2.Load Balancer & Target Group

3.ECR Repository for container storage

4.IAM roles for security

5.VPC, Subnets, NAT GW, IGW

2.2.In your local terraform visual code environment terminal, to initialize the necessary providers, execute the following command in your environment terminal
```language
terraform init
```
Upon completion of the initialization process, a successful prompt will be displayed, as shown

![image_alt](https://github.com/Tatenda-Prince/Automated-Container-Deployment-with-GitHub-Actions-CI-CD-to-AWS-ECS-Fargate/blob/6e777fc11759c41c01cb5e268b8cd58b2bb50de2/screenshots/Screenshot%202025-04-16%20194610.png)

2.3.Next, let’s ensure that our code does not contain any syntax errors by running the following command
```language
terraform validate
```
The command should generate a success message, confirming that it is valid, as demonstrated below.

![image_alt](https://github.com/Tatenda-Prince/Automated-Container-Deployment-with-GitHub-Actions-CI-CD-to-AWS-ECS-Fargate/blob/e5ae981933999e54cc23c0c92202c2bad88d9f0a/screenshots/Screenshot%202025-04-16%20194828.png)

2.4.Let’s now execute the following command to generate a list of all the modifications that Terraform will apply.
```language
terraform plan
```

![image_alt](https://github.com/Tatenda-Prince/Automated-Container-Deployment-with-GitHub-Actions-CI-CD-to-AWS-ECS-Fargate/blob/427a3d54558ac307b3e3ca46a1201ddf0616fc4c/screenshots/Screenshot%202025-04-16%20195343.png)

The list of changes that Terraform is anticipated to apply to the infrastructure resources should be displayed. The “+” sign indicates what will be added, while the “-” sign indicates what will be removed.

2.5.Now, let’s deploy this infrastructure! Execute the following command to apply the changes and deploy the resources. Note — Make sure to type “yes” to agree to the changes after running this command.
```language
terraform apply
```
Terraform will initiate the process of applying all the changes to the infrastructure. Kindly wait for a few seconds for the deployment process to complete.

![image_alt](https://github.com/Tatenda-Prince/Automated-Container-Deployment-with-GitHub-Actions-CI-CD-to-AWS-ECS-Fargate/blob/e40fc3ec82c5d2244cf8638dcbdbb0dde2270ba1/screenshots/Screenshot%202025-04-16%20195447.png)

## Success
The process should now conclude with a message indicating “Apply complete”, stating the total number of added, modified, and destroyed resources, accompanied by several resources. Please copy and save the ALB’s DNS URL, which will be required to access the web page from the browser.

![image_alt](https://github.com/Tatenda-Prince/Automated-Container-Deployment-with-GitHub-Actions-CI-CD-to-AWS-ECS-Fargate/blob/54e67d61feeb10b6ffaeb4599ff4bc40d4289f95/screenshots/Screenshot%202025-04-16%20195904.png)

## Step 3: Verify creation of our resources
3.1.In the AWS Management Console, head to the ECS Console and verify that there are two Tasks running as show below

![image_alt](https://github.com/Tatenda-Prince/Automated-Container-Deployment-with-GitHub-Actions-CI-CD-to-AWS-ECS-Fargate/blob/f845cce672b41027797d3b5d5fa92e7626124c3e/screenshots/Screenshot%202025-04-16%20200048.png)

3.2.In the AWS Management Console, head to the EC2 dashboard and verify that the ECS load Balancer was successfull created.

![image_alt](https://github.com/Tatenda-Prince/Automated-Container-Deployment-with-GitHub-Actions-CI-CD-to-AWS-ECS-Fargate/blob/6b9cfa7b660e6d3f8221c8002e705135f09dc480/screenshots/Screenshot%202025-04-16%20200219.png)

Also, navigate to the left pane, scroll down and select Target groups. Select the created Target group, scroll down, then verify that the instances Health status is healthy, as shown below.

![image_alt](https://github.com/Tatenda-Prince/Automated-Container-Deployment-with-GitHub-Actions-CI-CD-to-AWS-ECS-Fargate/blob/92e1563816801e040a6e621176dafabd8dc3bf2a/screenshots/Screenshot%202025-04-16%20200316.png)

Also, navigate to Cloudwatch under group logs check if there is any logs for our java application.

![image_alt](https://github.com/Tatenda-Prince/Automated-Container-Deployment-with-GitHub-Actions-CI-CD-to-AWS-ECS-Fargate/blob/d0e6037341115165af9a54f3df6f5a78035d4a77/screenshots/Screenshot%202025-04-16%20202507.png)


## Step 4:Verify the reachability to the website using its URL in browser
4.1.Open up your desired browser and paste the ALB’s DNS URL in your browser.

4.2.Note — Make sure to use the “http://” protocol and not https:// to reach the ALB.

![image_alt](https://github.com/Tatenda-Prince/Automated-Container-Deployment-with-GitHub-Actions-CI-CD-to-AWS-ECS-Fargate/blob/9b470c4fce78afc2e99b3adccb23213e1759fa7a/screenshots/Screenshot%202025-04-16%20200414.png)


## Step 5: Testing the CI/CD System
5.1.Every time you push changes to the master branch:

5.2.GitHub Actions triggers the workflow.

5.3.Builds a new Docker image from the updated code.

5.4.Pushes the image to AWS ECR.

5.5.Deploys a new task to ECS, replacing the old one.

5.6.Manage `Secrets` in GitHub:

1.Environment Variables:

The env section within the steps that require AWS credentials pulls the values from the secrets stored in the GitHub repository.

2.Navigate to Your Repository on GitHub

3.Add `Secrets Settings` > `Secrets and variables` > `Actions`.

4.Add the following secrets:

![image_alt](https://github.com/Tatenda-Prince/Automated-Container-Deployment-with-GitHub-Actions-CI-CD-to-AWS-ECS-Fargate/blob/2824a53a01705b02dae127faa90be1967b9e4606/screenshots/Screenshot%202025-03-13%20162644.png)

5.7.Push a Code Change to Trigger Deployment on your app homepage.
```language
git add .

git commit -m "Updated java-app  Homepage"

git push origin master
```
GitHub Actions will trigger:

1.Checkout code

2.Install dependencies & run tests

3.Build Docker image

4.Push to ECR

5.pdate ECS Task Definition

6.Deploy to Fargate

Go to GitHub → Actions and check the pipeline logs.

![image_alt](https://github.com/Tatenda-Prince/Automated-Container-Deployment-with-GitHub-Actions-CI-CD-to-AWS-ECS-Fargate/blob/9c3e6ef7d387d23b1a532b8a4ff842ef8ecb9784/screenshots/Screenshot%202025-04-16%20211202.png)


Access the application via the ALB DNS URL (output by Terraform)

![image_alt](https://github.com/Tatenda-Prince/Automated-Container-Deployment-with-GitHub-Actions-CI-CD-to-AWS-ECS-Fargate/blob/97113de8b61851cfb4540cb4d1cfeef56decbf05/screenshots/Screenshot%202025-04-16%20210915.png)


Verify ECS Service is running the new task.

![image_alt](https://github.com/Tatenda-Prince/Automated-Container-Deployment-with-GitHub-Actions-CI-CD-to-AWS-ECS-Fargate/blob/2f59b329ceda901dda91ee4f87faa9f0b5db935f/screenshots/Screenshot%202025-04-16%20210751.png)

## Future Enhancements
1.Add automated rollback using ECS deployment circuit breakers

2.Use AWS Secrets Manager for secret storage

3.Set up custom domain with Route53 + SSL

4.Integrate monitoring with Prometheus and Grafana

5.Enable blue/green deployments using CodeDeploy + ECS

## What I've Learned
1.Practical understanding of ECS Fargate, ECR, and VPC networking

2.Building and securing CI/CD pipelines with GitHub Actions

3.How to structure Terraform modules for scalable infra

4.The importance of automation and repeatability in modern DevOps

5.Real-world cloud architecture patterns and best practices







