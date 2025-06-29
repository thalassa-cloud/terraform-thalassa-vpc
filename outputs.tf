# =============================================================================
# VPC Outputs
# =============================================================================

output "vpc_id" {
  description = "The ID of the VPC"
  value       = thalassa_vpc.this.id
}

output "vpc_slug" {
  description = "The slug of the VPC"
  value       = thalassa_vpc.this.slug
}

output "vpc_cidrs" {
  description = "The CIDR blocks of the VPC"
  value       = thalassa_vpc.this.cidrs
}

# =============================================================================
# Subnet Outputs
# =============================================================================

output "public_subnet_ids" {
  description = "Map of public subnet IDs by subnet key"
  value = {
    for k, v in thalassa_subnet.public : k => v.id
  }
}

output "public_subnet_slugs" {
  description = "Map of public subnet slugs by subnet key"
  value = {
    for k, v in thalassa_subnet.public : k => v.slug
  }
}

output "private_subnet_ids" {
  description = "Map of private subnet IDs by subnet key"
  value = {
    for k, v in thalassa_subnet.private : k => v.id
  }
}

output "private_subnet_slugs" {
  description = "Map of private subnet slugs by subnet key"
  value = {
    for k, v in thalassa_subnet.private : k => v.slug
  }
}

output "subnet_slugs" {
  description = "Map of all subnet slugs by subnet key and type"
  value = merge(
    {
      for k, v in thalassa_subnet.public : "public-${k}" => v.slug
    },
    {
      for k, v in thalassa_subnet.private : "private-${k}" => v.slug
    }
  )
}

# =============================================================================
# Route Table Outputs
# =============================================================================

output "route_table_ids" {
  description = "Map of route table IDs by subnet key and type"
  value = merge(
    {
      for k, v in thalassa_route_table.public : "public-${k}" => v.id
    },
    {
      for k, v in thalassa_route_table.private : "private-${k}" => v.id
    }
  )
}

# =============================================================================
# NAT Gateway Outputs
# =============================================================================

output "nat_gateway_endpoint_ips" {
  description = "Map of NAT gateway endpoint IPs by subnet key"
  value = var.enable_nat_gateway ? {
    for k, v in thalassa_natgateway.this : k => v.endpoint_ip
  } : {}
}

output "nat_gateway_v4_ips" {
  description = "Map of NAT gateway IPv4 addresses by subnet key"
  value = var.enable_nat_gateway ? {
    for k, v in thalassa_natgateway.this : k => v.v4_ip
  } : {}
}

output "nat_gateway_v6_ips" {
  description = "Map of NAT gateway IPv6 addresses by subnet key"
  value = var.enable_nat_gateway ? {
    for k, v in thalassa_natgateway.this : k => v.v6_ip
  } : {}
}

output "nat_gateway_slugs" {
  description = "Map of NAT gateway slugs by subnet key"
  value = var.enable_nat_gateway ? {
    for k, v in thalassa_natgateway.this : k => v.slug
  } : {}
}
