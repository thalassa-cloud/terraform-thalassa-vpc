resource "thalassa_natgateway" "this" {
  for_each                   = var.enable_nat_gateway ? thalassa_subnet.public : {}
  name                       = format("%s-%s", var.name, each.key)
  description                = each.value.description
  organisation_id            = var.organisation_id
  subnet_id                  = each.value.id
  labels                     = merge(var.labels, each.value.labels, { "component" : "natgateway", "subnet" : each.key })
  security_group_attachments = var.nat_gateway_security_group_attachments
}

locals {
  default_destination_cidr = "0.0.0.0/0"
}

resource "thalassa_route_table_route" "public_default_route_via_natgw" {
  for_each        = var.enable_nat_gateway ? thalassa_subnet.public : {}
  organisation_id = var.organisation_id

  route_table_id   = thalassa_route_table.public[each.key].id
  destination_cidr = local.default_destination_cidr
  gateway_address  = thalassa_natgateway.this[each.key].endpoint_ip
}

output "natgateway_ids" {
  description = "Map of NAT gateway IDs by subnet key"
  value = {
    for k, v in thalassa_natgateway.this : k => v.id
  }
}
