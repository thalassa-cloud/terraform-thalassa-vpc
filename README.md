# Terraform Module for Thalassa Cloud VPC

This Terraform module creates a VPC (Virtual Private Cloud) infrastructure in Thalassa Cloud with support for public and private (no internet access) subnets, NAT Gateway, and route tables. It provides a flexible networking foundation for your cloud resources.

## Features

- Create a VPC with customizable CIDR blocks
- Deploy subnets with stretched network architecture
- Optional NAT Gateway deployment
- Configurable route tables for subnets
- Support for custom labels and descriptions

## Usage

```hcl
module "vpc" {
  source = "github.com/thalassa-cloud/terraform-thalassa-vpc"

  name             = "my-vpc"
  description      = "Production VPC for my application"
  organisation_id  = "org-123456"
  region          = "nl-01"
  
  vpc_cidrs = ["10.0.0.0/16"]

  public_subnets = {
    public-1 = {
      cidr        = "10.0.1.0/24"
      description = "Public subnet"
      labels = {
        environment = "production"
        tier       = "public"
      }
    }
  }

  private_subnets = {
    private-1 = {
      cidr        = "10.0.2.0/24"
      description = "Private subnet"
      labels = {
        environment = "production"
        tier       = "private"
      }
    }
  }

  enable_nat_gateway = true
  labels = {
    environment = "production"
    managed-by  = "terraform"
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_thalassa"></a> [thalassa](#requirement\_thalassa) (>= 0.6)

## Providers

The following providers are used by this module:

- <a name="provider_thalassa"></a> [thalassa](#provider\_thalassa) (0.6.0)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [thalassa_natgateway.this](https://registry.terraform.io/providers/thalassa-cloud/thalassa/latest/docs/resources/natgateway) (resource)
- [thalassa_route_table.private](https://registry.terraform.io/providers/thalassa-cloud/thalassa/latest/docs/resources/route_table) (resource)
- [thalassa_route_table.public](https://registry.terraform.io/providers/thalassa-cloud/thalassa/latest/docs/resources/route_table) (resource)
- [thalassa_route_table_route.public_default_route_via_natgw](https://registry.terraform.io/providers/thalassa-cloud/thalassa/latest/docs/resources/route_table_route) (resource)
- [thalassa_subnet.private](https://registry.terraform.io/providers/thalassa-cloud/thalassa/latest/docs/resources/subnet) (resource)
- [thalassa_subnet.public](https://registry.terraform.io/providers/thalassa-cloud/thalassa/latest/docs/resources/subnet) (resource)
- [thalassa_vpc.this](https://registry.terraform.io/providers/thalassa-cloud/thalassa/latest/docs/resources/vpc) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_description"></a> [description](#input\_description)

Description: The description of the VPC

Type: `string`

### <a name="input_name"></a> [name](#input\_name)

Description: The name of the VPC

Type: `string`

### <a name="input_organisation_id"></a> [organisation\_id](#input\_organisation\_id)

Description: The ID of the organisation to create the resources in. If not provided, the organisation set in the provider will be used.

Type: `string`

### <a name="input_thalassa_api"></a> [thalassa\_api](#input\_thalassa\_api)

Description: n/a

Type: `any`

### <a name="input_thalassa_token"></a> [thalassa\_token](#input\_thalassa\_token)

Description: n/a

Type: `any`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_enable_nat_gateway"></a> [enable\_nat\_gateway](#input\_enable\_nat\_gateway)

Description: Whether to deploy a NAT Gateway in the VPC

Type: `bool`

Default: `false`

### <a name="input_labels"></a> [labels](#input\_labels)

Description: The labels to apply to the VPC

Type: `map(string)`

Default: `{}`

### <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets)

Description: The private subnets to create in the VPC. Private Subnets have no access to the internet.

Type:

```hcl
map(object({
    cidr        = string
    description = optional(string)
    labels      = optional(map(string))
  }))
```

Default: `{}`

### <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets)

Description: The public subnets to create in the VPC. Public Subnets have access to the internet through a NAT Gateway.

Type:

```hcl
map(object({
    cidr               = string
    description        = optional(string)
    enable_nat_gateway = optional(bool)
    labels             = optional(map(string))
  }))
```

Default: `{}`

### <a name="input_region"></a> [region](#input\_region)

Description: The region to create the VPC resources in

Type: `string`

Default: `"nl-01"`

### <a name="input_vpc_cidrs"></a> [vpc\_cidrs](#input\_vpc\_cidrs)

Description: The CIDRs to create the VPC with

Type: `list(string)`

Default:

```json
[
  "10.0.0.0/16"
]
```

## Outputs

The following outputs are exported:

### <a name="output_nat_gateway_endpoint_ips"></a> [nat\_gateway\_endpoint\_ips](#output\_nat\_gateway\_endpoint\_ips)

Description: Map of NAT gateway endpoint IPs by subnet key

### <a name="output_nat_gateway_slugs"></a> [nat\_gateway\_slugs](#output\_nat\_gateway\_slugs)

Description: Map of NAT gateway slugs by subnet key

### <a name="output_nat_gateway_v4_ips"></a> [nat\_gateway\_v4\_ips](#output\_nat\_gateway\_v4\_ips)

Description: Map of NAT gateway IPv4 addresses by subnet key

### <a name="output_nat_gateway_v6_ips"></a> [nat\_gateway\_v6\_ips](#output\_nat\_gateway\_v6\_ips)

Description: Map of NAT gateway IPv6 addresses by subnet key

### <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids)

Description: Map of private subnet IDs by subnet key

### <a name="output_private_subnet_slugs"></a> [private\_subnet\_slugs](#output\_private\_subnet\_slugs)

Description: Map of private subnet slugs by subnet key

### <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids)

Description: Map of public subnet IDs by subnet key

### <a name="output_public_subnet_slugs"></a> [public\_subnet\_slugs](#output\_public\_subnet\_slugs)

Description: Map of public subnet slugs by subnet key

### <a name="output_route_table_ids"></a> [route\_table\_ids](#output\_route\_table\_ids)

Description: Map of route table IDs by subnet key and type

### <a name="output_subnet_slugs"></a> [subnet\_slugs](#output\_subnet\_slugs)

Description: Map of all subnet slugs by subnet key and type

### <a name="output_vpc_cidrs"></a> [vpc\_cidrs](#output\_vpc\_cidrs)

Description: The CIDR blocks of the VPC

### <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id)

Description: The ID of the VPC

### <a name="output_vpc_slug"></a> [vpc\_slug](#output\_vpc\_slug)

Description: The slug of the VPC
<!-- END_TF_DOCS -->

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This module is released under the MIT License.
