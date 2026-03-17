# AWS Infrastructure with Terraform - Practice Project

## Architecture Overview

![Infrastructure Diagram](./images/infrastructure-diagram.png)

*The diagram above illustrates the complete AWS infrastructure architecture deployed by this Terraform configuration.*

## Description

This project demonstrates how to deploy a complete AWS infrastructure using Terraform, including VPC, EC2 instances, RDS database, ECS cluster, and supporting resources. The infrastructure is designed to host a PHP application with MySQL database backend using containerized deployment on Amazon ECS.

## Prerequisites

Before getting started, ensure you have the following tools installed:

### Required Tools

1. **Terraform** (v1.0 or higher)
   ```bash
   # Install on macOS using Homebrew
   brew install terraform

   # Verify installation
   terraform --version
   ```

2. **AWS CLI** (v2.0 or higher)
   ```bash
   # Install on macOS using Homebrew
   brew install awscli

   # Configure AWS credentials
   aws configure
   ```

3. **Docker** (for building and pushing container images)
   ```bash
   # Install Docker Desktop from https://docker.com
   # Verify installation
   docker --version
   ```

## Configuration Customization

Before deploying the infrastructure, you need to customize the following configuration files according to your requirements:

### 1. Region Configuration

**File**: `variables.tf` (Line 2)
```terraform
variable "region" {
  default = "your-preferred-region"  # Change to your desired AWS region
}
```

### 2. Security Group IP Configuration

**File**: `modules/ec2/security_groups.tf` (Line 19)
```terraform
resource "aws_vpc_security_group_ingress_rule" "practice_sg_ingress" {
    security_group_id = aws_security_group.practice_sg.id
    cidr_ipv4 = "YOUR_IP_ADDRESS/32" # Replace with your actual IP address
    from_port = 22
    ip_protocol = "tcp"
    to_port = 22
}
```

**Note**: You can find your IP address by visiting [whatismyipaddress.com](https://whatismyipaddress.com) or running:
```bash
curl ifconfig.me
```

## Deployment Steps

Follow these steps to deploy the infrastructure:

### 1. Initialize Terraform

```bash
terraform init
```

This command initializes the Terraform working directory and downloads the required provider plugins.

### 2. Review the Deployment Plan

```bash
terraform plan
```

This command shows you what resources Terraform will create, modify, or destroy.

### 3. Validate Configuration

```bash
terraform validate
```

This command validates the Terraform configuration files for syntax errors.

### 4. Deploy Infrastructure

```bash
terraform apply
```

Type `yes` when prompted to confirm the deployment. This process may take 10-15 minutes to complete.

## Container Deployment

After the infrastructure is successfully deployed, follow these steps to build and deploy your application container:

### 1. Build Docker Image

```bash
docker build --platform linux/amd64 -t php-ecs-practice .
```

### 2. Login to Amazon ECR

```bash
aws ecr get-login-password \
    --region us-east-1 \
    | docker login \
    --username AWS \
    --password-stdin <account-id>.dkr.ecr.us-east-1.amazonaws.com
```

**Note**: Replace `<account-id>` with your actual AWS Account ID and update the region if you changed it in the configuration.

### 3. Tag Docker Image

```bash
docker tag php-ecs-practice:latest \
    <account-id>.dkr.ecr.us-east-1.amazonaws.com/practice_ecr_repository:latest
```

### 4. Push Image to ECR

```bash
docker push <account-id>.dkr.ecr.us-east-1.amazonaws.com/practice_ecr_repository:latest
```

## Infrastructure Components

This Terraform configuration creates the following AWS resources:

- **VPC** with public and private subnets across multiple AZs
- **EC2 Instance** for application hosting
- **RDS MySQL Database** with multi-AZ deployment
- **ECS Cluster** for containerized workloads
- **ECR Repository** for storing container images
- **Security Groups** for network access control
- **IAM Roles and Policies** for service permissions
- **Load Balancer** (if configured)

## Future Enhancements

This project is continuously evolving. The following features are planned for future implementation:

### Monitoring & Logging
- **CloudWatch Logs**: Implement centralized logging for ECS tasks and EC2 instances
- **CloudWatch Metrics**: Add custom metrics and dashboards for application monitoring
- **Log Groups**: Organize logs by service and retention policies

### Configuration Management
- **AWS Parameter Store**: Store environment variables and configuration securely
- **ECS Environment Variables**: Integrate Parameter Store with ECS task definitions
- **Secrets Manager**: Manage database credentials and API keys securely

### High Availability & Performance
- **Application Load Balancer (ALB)**: Distribute traffic across multiple ECS tasks
- **Auto Scaling**: Implement ECS service auto scaling based on CPU/memory utilization
- **Multi-AZ Deployment**: Enhance RDS with automatic failover capabilities

### Security Enhancements
- **VPC Endpoints**: Reduce internet traffic for AWS service communications
- **WAF Integration**: Web Application Firewall for additional security
- **SSL/TLS Certificates**: Implement HTTPS with AWS Certificate Manager

### DevOps Improvements
- **CI/CD Pipeline**: Automate deployment using AWS CodePipeline or GitHub Actions
- **Infrastructure as Code**: Modularize Terraform for better reusability
- **Testing**: Add infrastructure testing with tools like Terratest

## Cleanup

To destroy all created resources:

```bash
terraform destroy
```

Type `yes` when prompted to confirm the destruction.

## Troubleshooting

### Common Issues

1. **AWS Credentials**: Ensure your AWS credentials are properly configured using `aws configure`
2. **Region Mismatch**: Verify that all configuration files use the same AWS region
3. **IP Address**: Make sure to update the CIDR block with your actual IP address for SSH access
4. **Resource Limits**: Check your AWS account limits if you encounter resource creation errors

### Getting Help

- Check Terraform documentation: [terraform.io/docs](https://terraform.io/docs)
- Review AWS documentation for specific services
- Validate your configuration with `terraform validate` before applying