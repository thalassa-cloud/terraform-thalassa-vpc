resource "thalassa_subnet" "public" {
  for_each        = var.public_subnets
  name            = format("%s-%s", var.name, each.key)
  description     = each.value.description
  organisation_id = var.organisation_id
  vpc_id          = thalassa_vpc.this.id
  cidr            = each.value.cidr
  labels          = merge(var.labels, each.value.labels, { "component" : "subnet", "subnet" : each.key, "type" : "public" })
  route_table_id  = thalassa_route_table.public[each.key].id
}

resource "thalassa_route_table" "public" {
  for_each        = var.public_subnets
  name            = format("%s-%s", var.name, each.key)
  description     = each.value.description
  organisation_id = var.organisation_id
  vpc_id          = thalassa_vpc.this.id
  labels          = merge(var.labels, each.value.labels, { "component" : "route_table", "subnet" : each.key, "type" : "public" })
}

resource "thalassa_subnet" "private" {
  for_each        = var.private_subnets
  name            = format("%s-%s", var.name, each.key)
  description     = each.value.description
  organisation_id = var.organisation_id
  vpc_id          = thalassa_vpc.this.id
  cidr            = each.value.cidr
  labels          = merge(var.labels, each.value.labels, { "component" : "subnet", "subnet" : each.key, "type" : "private" })
  route_table_id  = thalassa_route_table.private[each.key].id
}

resource "thalassa_route_table" "private" {
  for_each        = var.private_subnets
  name            = format("%s-%s", var.name, each.key)
  description     = each.value.description
  organisation_id = var.organisation_id
  vpc_id          = thalassa_vpc.this.id
  labels          = merge(var.labels, each.value.labels, { "component" : "route_table", "subnet" : each.key, "type" : "private" })
}


