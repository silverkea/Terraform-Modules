variable "app_port" {
  type        = number
  description = "Port the application listens on"
  default     = 80
}

variable "autoscale_group_size" {
  type        = number
  description = "Default size of autoscale group."
}

variable "autoscale_group_min_max" {
  type = object({
    min = number
    max = number
  })

  description = "The minimum and maximum size for the autoscale group."
}

variable "environment" {
  type        = string
  description = "(Required) Environment of all resources"
}

variable "instance_type" {
  type        = string
  description = "Instance type for Autoscale group"
  default     = "t3.micro"
}

variable "launce_template_ami" {
  type        = string
  description = "AMI ID to use for the launch template"
}

variable "prefix" {
  type        = string
  description = "(Required) Prefix to use for all resources in this module."
}

variable "public_subnets" {
  type        = list(string)
  description = "(Required) List of public subnet IDs for the VPC."
}

variable "user_data_content" {
  type        = string
  description = "User data script content for EC2 instances"
}

variable "vpc_id" {
  type        = string
  description = "(Required) VPC ID where resources will be deployed."
}