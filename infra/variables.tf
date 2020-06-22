#### Common parameters #####

variable "aws_region" {}

variable "role_arn" {
  description = "Arn of the role to assume."
}

### Tags and Naming parameters #####

variable "name" {
  description = "The name prefix for AWS resources"
}

variable "environment" {
  description = "Name of the environment"
}

variable "jenkins_build_number" {
  description = "Jenkins build number while deploying terraform templates."
}

variable "jenkins_job_name" {
  description = "Jenkins job name used to deploy terraform templates."
}


##### VPC Parameters #####
variable "vpc_cidr" {
  description = "(Required) The CIDR block for the VPC"
}

variable "public_subnet_ids" {
  description = "A list of public subnets inside the VPC."
  type        = "list"
}

variable "private_subnet_ids" {
  description = "A list of private subnets inside the VPC."
  type        = "list"
}

variable "protected_subnet_ids" {
  description = "A list of protected subnets inside the VPC."
  type        = "list"
}

variable "nat_subnet_ids" {
  description = "A list of NAT subnets inside the VPC, for outbound filtering"
  type        = "list"
}

variable "global_cidr" {
  description = "CIDR that match global CIDR for example 0.0.0.0/0"
}

variable "enable_dns_hostnames" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = true
}

variable "enable_dns_support" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = true
}

variable "enable_nat_gateway" {
  description = "should be true if you want to provision NAT Gateways for each of your private networks"
  default     = true
}

variable "enable_transit" {
  description = "Set to true to create a VGW and add it the TransitVPC."
  default     = false
}

variable "map_public_ip_on_launch" {
  description = "should be false if you do not want to auto-assign public IP on launch"
  default     = false
}

variable "zone_name" {
  description = "(Required) This is the name of the hosted zone."
}

variable "enable_vpn_gateway" {
  description = "Enable VPN Gateway for VPC"
}
