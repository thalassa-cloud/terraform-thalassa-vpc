resource "thalassa_security_group" "nat_gateway" {
  count                    = var.enable_nat_gateway && var.create_vpc_to_nat_gateway_security_group ? 1 : 0
  name                     = var.nat_gateway_security_group_name != null ? var.nat_gateway_security_group_name : format("%s-nat-gateway", var.name)
  description              = var.nat_gateway_security_group_description != null ? var.nat_gateway_security_group_description : "Security group for NAT Gateway in ${var.name}"
  organisation_id          = var.organisation_id
  vpc_id                   = thalassa_vpc.this.id
  labels                   = merge(var.labels, var.nat_gateway_security_group_labels, { "component" : "security_group", "type" : "nat_gateway" })
  allow_same_group_traffic = var.nat_gateway_security_group_allow_same_group_traffic

  dynamic "ingress_rule" {
    for_each = var.nat_gateway_security_group_ingress_rules
    content {
      name                           = ingress_rule.value.name
      ip_version                     = ingress_rule.value.ip_version
      protocol                       = ingress_rule.value.protocol
      priority                       = ingress_rule.value.priority
      remote_type                    = ingress_rule.value.remote_type
      remote_address                 = try(ingress_rule.value.remote_address, null)
      remote_security_group_identity = try(ingress_rule.value.remote_security_group_identity, null)
      port_range_min                 = try(ingress_rule.value.port_range_min, null)
      port_range_max                 = try(ingress_rule.value.port_range_max, null)
      policy                         = ingress_rule.value.policy
    }
  }

  dynamic "egress_rule" {
    for_each = var.nat_gateway_security_group_egress_rules
    content {
      name                           = egress_rule.value.name
      ip_version                     = egress_rule.value.ip_version
      protocol                       = egress_rule.value.protocol
      priority                       = egress_rule.value.priority
      remote_type                    = egress_rule.value.remote_type
      remote_address                 = try(egress_rule.value.remote_address, null)
      remote_security_group_identity = try(egress_rule.value.remote_security_group_identity, null)
      port_range_min                 = try(egress_rule.value.port_range_min, null)
      port_range_max                 = try(egress_rule.value.port_range_max, null)
      policy                         = egress_rule.value.policy
    }
  }
}

# Security group for VPC resources to connect to NAT Gateway
# This security group has an egress rule allowing traffic to the NAT gateway security group.
resource "thalassa_security_group" "vpc_to_nat_gateway" {
  count                    = var.enable_nat_gateway && var.create_vpc_to_nat_gateway_security_group ? 1 : 0
  name                     = var.vpc_to_nat_gateway_security_group_name != null ? var.vpc_to_nat_gateway_security_group_name : format("%s-vpc-to-nat-gateway", var.name)
  description              = var.vpc_to_nat_gateway_security_group_description != null ? var.vpc_to_nat_gateway_security_group_description : "Security group for VPC resources to connect to NAT Gateway in ${var.name}"
  organisation_id          = var.organisation_id
  vpc_id                   = thalassa_vpc.this.id
  labels                   = merge(var.labels, var.vpc_to_nat_gateway_security_group_labels, { "component" : "security_group", "type" : "vpc_to_nat_gateway" })
  allow_same_group_traffic = false

  egress_rule {
    name                           = "allow-to-nat-gateway"
    ip_version                     = "ipv4"
    protocol                       = "all"
    priority                       = 100
    remote_type                    = "securityGroup"
    remote_security_group_identity = thalassa_security_group.nat_gateway[0].id
    port_range_min                 = null
    port_range_max                 = null
    policy                         = "allow"
  }

  depends_on = [thalassa_security_group.nat_gateway]
}
