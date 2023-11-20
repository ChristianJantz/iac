<!-- BEGIN_TF_DOCS -->
# Azure Resource Group Terraform module

## Usage

```
provider "azurerm" {
  features {}
}

module "rg" {
  source = "../"

  resource_groups = {
    shared-services = {
      resource_group_name = "rg-test-gwc"
      location            = "germanywestcentral"
    }

    datascience = {
      resource_group_name = "rg-dummy-gwc"
      location            = "germanywestcentral"
    }
  }
}
```

## Terraform Usage

To run this example you need to execute following Terraform commands

```hcl
terraform init
terraform plan
terraform apply
```

Run `terraform destroy` when you don't need these resources.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.5.0, < 1.6.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 2.40.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0, < 4.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 4.0.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.0, < 4.0 |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rg_id"></a> [rg\_id](#output\_rg\_id) | List of IDs of the Resource Groups |
| <a name="output_rg_location"></a> [rg\_location](#output\_rg\_location) | List of Locations of the Resource Groups |
| <a name="output_rg_name"></a> [rg\_name](#output\_rg\_name) | List of Names of the Resource Groups |

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| <a name="input_resource_groups"></a> [resource\_groups](#input\_resource\_groups) | Each resource group will create an object | `{}` |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

<!-- END_TF_DOCS -->