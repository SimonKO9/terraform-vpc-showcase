variable "env_name" {
  description = "A short, lowercase descriptive name of the environment, e.g. dev, stg, prod etc."
}

variable "extra_tag_owner" {
  description = "Owner managing the VPC and related resources."
}

variable "vpc_cidr" {
  type        = string
  description = "Main CIDR of the VPC."
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones corresponding to subnets."
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDRs for private subnets."
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDRs for public subnets."
}
