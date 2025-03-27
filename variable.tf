variable "aws_access_key" {
  description = "AWS ACCESS KEY"
  type = string
}

variable "aws_secret_key" {
  description = "AWS SECRET KEY"
  type = string
}
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "key_name" {
  description = "Name of the SSH key to use"
  type        = string
  default     = "Naman-training"
}


variable "aws_availability_zone" {
  description = "AWS Availability Zone"
  type        = string
  default     = "ap-south-1a"  
}
