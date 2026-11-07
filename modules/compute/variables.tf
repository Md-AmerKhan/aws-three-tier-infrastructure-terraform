
variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "ssh_key_name" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "web_sg_id" {
  type = string
}

variable "app_sg_id" {
  type = string
}

variable "database_sg_id" {
  type = string
}

variable "web_target_group_arn" {
  type = string
}

variable "app_target_group_arn" {
  type = string
}
variable "private_alb_dns_name" {
  description = "DNS name of the internal application load balancer"
  type        = string
}
variable "ssm_instance_profile_name" {
  description = "IAM instance profile for Systems Manager access"
  type        = string
}
