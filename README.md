<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_thalassa"></a> [thalassa](#requirement\_thalassa) | >= 0.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_thalassa"></a> [thalassa](#provider\_thalassa) | 0.3.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [thalassa_natgateway.this](https://registry.terraform.io/providers/thalassa-cloud/thalassa/latest/docs/resources/natgateway) | resource |
| [thalassa_route_table.private](https://registry.terraform.io/providers/thalassa-cloud/thalassa/latest/docs/resources/route_table) | resource |
| [thalassa_route_table.public](https://registry.terraform.io/providers/thalassa-cloud/thalassa/latest/docs/resources/route_table) | resource |
| [thalassa_route_table_route.public_default_route_via_natgw](https://registry.terraform.io/providers/thalassa-cloud/thalassa/latest/docs/resources/route_table_route) | resource |
| [thalassa_subnet.private](https://registry.terraform.io/providers/thalassa-cloud/thalassa/latest/docs/resources/subnet) | resource |
| [thalassa_subnet.public](https://registry.terraform.io/providers/thalassa-cloud/thalassa/latest/docs/resources/subnet) | resource |
| [thalassa_vpc.this](https://registry.terraform.io/providers/thalassa-cloud/thalassa/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | The description of the VPC | `string` | n/a | yes |
| <a name="input_enable_nat_gateway"></a> [enable\_nat\_gateway](#input\_enable\_nat\_gateway) | Whether to deploy a NAT Gateway in the VPC | `bool` | `false` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | The labels to apply to the VPC | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the VPC | `string` | n/a | yes |
| <a name="input_organisation_id"></a> [organisation\_id](#input\_organisation\_id) | The ID of the organisation to create the resources in. If not provided, the organisation set in the provider will be used. | `string` | n/a | yes |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | The private subnets to create in the VPC. Private Subnets have no access to the internet. | <pre>map(object({<br/>    cidr        = string<br/>    description = optional(string)<br/>    labels      = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | The public subnets to create in the VPC. Public Subnets have access to the internet through a NAT Gateway. | <pre>map(object({<br/>    cidr               = string<br/>    description        = optional(string)<br/>    enable_nat_gateway = optional(bool)<br/>    labels             = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_region"></a> [region](#input\_region) | The region to create the VPC resources in | `string` | `"nl-01"` | no |
| <a name="input_vpc_cidrs"></a> [vpc\_cidrs](#input\_vpc\_cidrs) | The CIDRs to create the VPC with | `list(string)` | <pre>[<br/>  "10.0.0.0/16"<br/>]</pre> | no |
| <a name="input_zones"></a> [zones](#input\_zones) | The zones to create the VPC resources in | `list(string)` | <pre>[<br/>  "nl-01a",<br/>  "nl-01b",<br/>  "nl-01c"<br/>]</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->