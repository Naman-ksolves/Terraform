# AWS Region
variable "aws_region" {
  default = "us-east-1"
}

# VPC Configuration
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

# Private Subnets
variable "private_subnet_cidrs" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

# Public Subnets (Needed for ALB)
variable "public_subnet_cidrs" {
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

# EKS Cluster Configuration
variable "eks_cluster_name" {
  default = "my-eks-cluster"
}

variable "eks_role_arn" {
  default = "arn:aws:iam::<your-account-id>:role/EKSClusterRole"  # Replace with actual IAM role ARN
}

# Application Load Balancer (ALB)
variable "alb_name" {
  default = "my-alb"
}

# Auto Scaling Group (ASG)
variable "asg_desired_capacity" {
  default = 2
}

variable "asg_max_size" {
  default = 4
}

variable "asg_min_size" {
  default = 1
}

# EC2 Configuration for Launch Template
variable "ami_id" {
  default = "ami-xxxxxxxxxxxx"  # Replace with a valid AMI ID for your region
}

variable "instance_type" {
  default = "t3.medium"
}

variable "key_name" {
  default = "my-key"  # Replace with your actual key pair name
}

# API Gateway
variable "api_gateway_name" {
  default = "my-api-gateway"
}

# Cognito User Pool
variable "cognito_user_pool_name" {
  default = "my-user-pool"
}

# Route 53
variable "route53_domain" {
  default = "example.com"
}

# WAF
variable "waf_name" {
  default = "mywaf"
}

variable "waf_metric_name" {
  default = "mywafmetrics"
}
