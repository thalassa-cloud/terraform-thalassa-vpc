
terraform {
  required_providers {
    thalassa = {
      version = ">= 0.6"
      source  = "thalassa-cloud/thalassa"
    }
  }
}

variable "thalassa_token" {
  type        = string
  description = "Thalassa API token"
  sensitive   = true
}

variable "thalassa_api" {
  type        = string
  description = "Thalassa API URL"
}

variable "organisation_id" {
  type        = string
  description = "Thalassa organisation Identity or slug"
}

variable "region" {
  type        = string
  description = "Thalassa region"
}


provider "thalassa" {
  token           = var.thalassa_token
  api             = var.thalassa_api
  organisation_id = var.organisation_id
}

module "vpc" {
  source          = "../../"
  organisation_id = var.organisation_id
  name            = "vpcmodule"
  description     = "VPC module"
  region          = var.region
  labels = {
    "module" = "vpc"
  }
  # module variables
  enable_nat_gateway = true

  public_subnets = {
    "public" = {
      "cidr"        = "10.0.1.0/24"
      "description" = "Public subnet"
    }
  }

  private_subnets = {
    "private" = {
      "cidr"        = "10.0.2.0/24"
      "description" = "Private subnet"
    }
  }

}
