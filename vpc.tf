
resource "thalassa_vpc" "this" {
  name            = var.name
  description     = var.description
  organisation_id = var.organisation_id
  cidrs           = var.vpc_cidrs
  labels          = var.labels
  region          = var.region
}
