variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project Name"
  type        = string
  default     = "production-devops-project"
}

variable "environment" {
  description = "Environment Name"
  type        = string
  default     = "dev"
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t2.micro"
}
