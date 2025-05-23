
variable "organisation_id" {
  description = "The ID of the organisation to create the resources in. If not provided, the organisation set in the provider will be used."
  type        = string
  nullable    = true
}

variable "name" {
  description = "The name of the VPC"
  type        = string
  nullable    = false
}

variable "description" {
  description = "The description of the VPC"
  type        = string
  nullable    = true
}

variable "region" {
  description = "The region to create the VPC resources in"
  type        = string
  nullable    = false
  default     = "nl-01"
}

variable "public_subnets" {
  description = "The public subnets to create in the VPC. Public Subnets have access to the internet through a NAT Gateway."
  type = map(object({
    cidr               = string
    description        = optional(string)
    enable_nat_gateway = optional(bool)
    labels             = optional(map(string))
  }))
  default = {}
}

variable "private_subnets" {
  description = "The private subnets to create in the VPC. Private Subnets have no access to the internet."
  type = map(object({
    cidr        = string
    description = optional(string)
    labels      = optional(map(string))
  }))
  default = {}
}

variable "labels" {
  description = "The labels to apply to the VPC"
  type        = map(string)
  default     = {}
}

variable "vpc_cidrs" {
  description = "The CIDRs to create the VPC with"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "enable_nat_gateway" {
  description = "Whether to deploy a NAT Gateway in the VPC"
  type        = bool
  default     = false
}
