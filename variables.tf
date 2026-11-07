
variable "aws_region" {
  description = "AWS region for the assignment"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "Amazon Linux 2 AMI ID for ap-south-1"
  type        = string
}

variable "ssh_key_name" {
  description = "Existing AWS EC2 key pair name"
  type        = string
}

variable "allowed_admin_cidr" {
  description = "Your approved public IP address in CIDR notation"
  type        = string
}

variable "common_tags" {
  description = "Tags applied to all resources"
  type        = map(string)

  default = {
    Environment = "Assignment"
    Project     = "Terraform-3Tier"
    Owner       = "Md Amer Khan"
  }
}
