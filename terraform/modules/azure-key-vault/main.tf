data "azurerm_client_config" "current" {}

##################################################################
# Keyvault Creation
##################################################################

resource "azurerm_key_vault" "akv" {
  name                            = lower(var.akv_name)
  resource_group_name             = var.resource_group_name
  location                        = var.location
  sku_name                        = var.key_vault_sku_tier
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_template_deployment = var.enabled_for_template_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enable_rbac_authorization       = var.enable_rbac_authorization
  soft_delete_retention_days      = var.soft_delete_retention_days
  public_network_access_enabled   = var.public_network_access_enabled
  purge_protection_enabled        = var.purge_protection_enabled

  dynamic "access_policy" {
    for_each = var.access_policies

    content {
      tenant_id               = data.azurerm_client_config.current.tenant_id
      object_id               = access_policy.value.object_id
      certificate_permissions = access_policy.value.certificate_permissions
      key_permissions         = access_policy.value.key_permissions
      secret_permissions      = access_policy.value.secret_permissions
      storage_permissions     = access_policy.value.storage_permissions
    }
  }
}

# Private DNS Name for Azure Key Vault
resource "azurerm_private_dns_zone" "akv_dns" {
  name                = "${lower(var.akv_name)}.privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_key_vault.akv.resource_group_name
  tags = var.tags
}

# Private DNS Name Link to attach to the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "akv_dns_vnet_link" {
  depends_on            = [azurerm_key_vault.akv, azurerm_private_dns_zone.akv_dns]
  name                  = "${azurerm_key_vault.akv.name}-dns-vnet-link"
  resource_group_name   = azurerm_key_vault.akv.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.akv_dns.name
  virtual_network_id    = var.akv_vnet_id
  registration_enabled  = false
  tags = var.tags
}


# Private Endpoint
resource "azurerm_private_endpoint" "akv_private_endpoint" {
  name                = "pe-${azurerm_key_vault.akv.name}"
  location            = azurerm_key_vault.akv.location
  resource_group_name = azurerm_key_vault.akv.resource_group_name
  subnet_id           = var.akv_subnet_id
  tags = var.tags

  private_service_connection {
    name                           = "psc-${azurerm_key_vault.akv.name}"
    private_connection_resource_id = azurerm_key_vault.akv.id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "pdzg-${azurerm_key_vault.akv.name}"
    private_dns_zone_ids = [azurerm_private_dns_zone.akv_dns.id]
  }
}

##################################################################
# Keyvault Secret - Random password Creation if value is empty
##################################################################

resource "random_password" "secrets" {
  for_each    = { for k, v in var.secrets : k => v if v == "" }
  length      = 32
  min_upper   = 4
  min_lower   = 2
  min_numeric = 4
  min_special = 4

  keepers = { # Arbitrary map of values that, when changed, will trigger recreation of resource.
    name = each.key
  }
}

resource "azurerm_key_vault_secret" "keys" {

  for_each     = var.secrets
  name         = each.key
  value        = each.value != "" ? each.value : random_password.secrets[each.key].result
  key_vault_id = azurerm_key_vault.akv.id

  lifecycle {
    ignore_changes = [
      tags,
      value,
    ]
  }
}
