# Azure <> Terraform module
Terraform module for creation Azure <>

## Usage

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.27.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >=3.4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.27.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >=3.4.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_postgresql_flexible_server.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server) | resource |
| [azurerm_postgresql_flexible_server_database.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_database) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_string.login](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_administrator_login"></a> [administrator\_login](#input\_administrator\_login) | The administrator login name for the PostgreSQL Flexible Server | `string` | `null` | no |
| <a name="input_administrator_password"></a> [administrator\_password](#input\_administrator\_password) | The administrator password for the PostgreSQL Flexible Server | `string` | `null` | no |
| <a name="input_databases"></a> [databases](#input\_databases) | List of databases to create | <pre>list(object({<br>    name      = string<br>    collation = string<br>    charset   = string<br>  }))</pre> | `[]` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project name | `string` | n/a | yes |
| <a name="input_psql_version"></a> [psql\_version](#input\_psql\_version) | The version of the PostgreSQL Flexible Server | `string` | `"12"` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | Resource group name | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU name for the PostgreSQL Flexible Server | `string` | `"GP_Standard_D4s_v3"` | no |
| <a name="input_storage_mb"></a> [storage\_mb](#input\_storage\_mb) | Storage in MB | `number` | `32768` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the virtual network subnet to create the PostgreSQL Flexible Server | `string` | `null` | no |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | PostgreSQL server name suffix | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags | `map(string)` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | Specifies the Availability Zone in which the PostgreSQL Flexible Server should be located | `number` | `1` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | The ID of the private DNS zone to create the PostgreSQL Flexible Server | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_administrator_login"></a> [administrator\_login](#output\_administrator\_login) | The administrator login name for the PostgreSQL Flexible Server |
| <a name="output_administrator_password"></a> [administrator\_password](#output\_administrator\_password) | The administrator password for the PostgreSQL Flexible Server |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | The FQDN of the PostgreSQL Flexible Server |
| <a name="output_id"></a> [id](#output\_id) | The ID of the PostgreSQL Flexible Server |
| <a name="output_name"></a> [name](#output\_name) | The name of the PostgreSQL Flexible Server |
| <a name="output_public_network_access_enabled"></a> [public\_network\_access\_enabled](#output\_public\_network\_access\_enabled) | Is public network access enabled? |
<!-- END_TF_DOCS -->

## License

Apache 2 Licensed. For more information please see [LICENSE](https://github.com/data-platform-hq/terraform-azurerm<>/tree/master/LICENSE)
