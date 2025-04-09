resource "thalassa_natgateway" "this" {
  for_each        = var.enable_nat_gateway ? thalassa_subnet.public : {}
  name            = format("%s-%s", var.name, each.key)
  description     = each.value.description
  organisation_id = var.organisation_id
  subnet_id       = each.value.id
  labels          = merge(var.labels, each.value.labels, { "component" : "natgateway", "subnet" : each.key })
}


resource "thalassa_route_table_route" "public_default_route_via_natgw" {
  for_each        = var.enable_nat_gateway ? thalassa_subnet.public : {}

  route_table_id   = thalassa_route_table.public[each.key].id
  destination_cidr = "0.0.0.0/0"
  gateway_address  = thalassa_natgateway.this[each.key].endpoint_ip
}
