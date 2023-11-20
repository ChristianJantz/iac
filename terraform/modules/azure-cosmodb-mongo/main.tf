# https://registry.terraform.io/providers/hashicorp/azurerm/latest
provider "azurerm" {
  features {}
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network
data "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet
data "azurerm_subnet" "snet" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = var.resource_group_name
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account
resource "azurerm_cosmosdb_account" "this" {
  name                = var.cosmosdb_account_name
  resource_group_name = var.resource_group_name
  location            = var.cosmosdb_account_location
  offer_type          = var.offer_type
  consistency_policy {
    consistency_level       = var.consistency_level
    max_interval_in_seconds = var.max_interval_in_seconds
    max_staleness_prefix    = var.max_staleness_prefix
  }
  dynamic "geo_location" {
    for_each = var.geo_locations
    content {
      location          = geo_location.value.location
      failover_priority = geo_location.value.failover_priority
      zone_redundant    = geo_location.value.zone_redundant
    }
  }
  tags = merge(var.general_tags, var.cosmosdb_account_tags)
  analytical_storage { schema_type = var.schema_type }
  capacity { total_throughput_limit = var.total_throughput_limit }
  create_mode                   = try(var.cosmosdb_account_backup[0].type == "Continuous" ? var.create_mode : null)
  default_identity_type         = var.default_identity_type
  kind                          = var.kind
  ip_range_filter               = var.ip_range_filter
  enable_free_tier              = var.enable_free_tier
  analytical_storage_enabled    = var.analytical_storage_enabled
  enable_automatic_failover     = var.enable_automatic_failover
  public_network_access_enabled = var.public_network_access_enabled
  dynamic "capabilities" {
    for_each = var.capabilities
    content { name = capabilities.value }
  }
  is_virtual_network_filter_enabled = var.is_virtual_network_filter_enabled
  key_vault_key_id                  = var.key_vault_key_id
  dynamic "virtual_network_rule" {
    for_each = var.virtual_network_rules
    content {
      id                                   = virtual_network_rule.value.id
      ignore_missing_vnet_service_endpoint = virtual_network_rule.value.ignore_missing_vnet_service_endpoint
    }
  }
  enable_multiple_write_locations       = var.enable_multiple_write_locations
  access_key_metadata_writes_enabled    = var.access_key_metadata_writes_enabled
  mongo_server_version                  = var.mongo_server_version
  network_acl_bypass_for_azure_services = var.network_acl_bypass_for_azure_services
  network_acl_bypass_ids                = var.network_acl_bypass_ids
  local_authentication_disabled         = var.local_authentication_disabled
  dynamic "backup" {
    for_each = var.cosmosdb_account_backup
    content {
      type                = backup.value.type
      interval_in_minutes = backup.value.interval_in_minutes
      retention_in_hours  = backup.value.retention_in_hours
      storage_redundancy  = backup.value.storage_redundancy
    }
  }
  dynamic "cors_rule" {
    for_each = var.cosmosdb_account_cors_rule
    content {
      allowed_headers    = cors_rule.value.allowed_headers
      allowed_methods    = cors_rule.value.allowed_methods
      allowed_origins    = cors_rule.value.allowed_origins
      exposed_headers    = cors_rule.value.exposed_headers
      max_age_in_seconds = cors_rule.value.max_age_in_seconds
    }
  }
  dynamic "identity" {
    for_each = var.cosmosdb_account_identity
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }
  dynamic "restore" {
    for_each = var.cosmosdb_account_restore
    content {
      source_cosmosdb_account_id = restore.value.source_cosmosdb_account_id
      restore_timestamp_in_utc   = restore.value.restore_timestamp_in_utc
      dynamic "database" {
        for_each = restore.value.database
        content {
          name             = database.value.name
          collection_names = database.value.collection_names
        }
      }
    }
  }
  timeouts {
    create = var.cosmosdb_account_timeouts.create
    update = var.cosmosdb_account_timeouts.update
    read   = var.cosmosdb_account_timeouts.read
    delete = var.cosmosdb_account_timeouts.delete
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_mongo_database
resource "azurerm_cosmosdb_mongo_database" "this" {
  for_each            = var.cosmosdb_mongo_databases
  name                = each.value.name
  resource_group_name = azurerm_cosmosdb_account.this.resource_group_name
  account_name        = azurerm_cosmosdb_account.this.name
  throughput          = each.value.throughput
  dynamic "autoscale_settings" {
    for_each = each.value.autoscale_settings
    content {
      max_throughput = each.value.throughput == null ? autoscale_settings.value.max_throughput : null
    }
  }
  timeouts {
    create = var.cosmosdb_mongo_database_timeouts.create
    update = var.cosmosdb_mongo_database_timeouts.update
    read   = var.cosmosdb_mongo_database_timeouts.read
    delete = var.cosmosdb_mongo_database_timeouts.delete
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint
# https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource
resource "azurerm_private_endpoint" "this" {
  name                          = "pe-${azurerm_cosmosdb_account.this.name}"
  resource_group_name           = azurerm_cosmosdb_account.this.resource_group_name
  location                      = azurerm_cosmosdb_account.this.location
  subnet_id                     = data.azurerm_subnet.snet.id
  custom_network_interface_name = var.custom_network_interface_name
  private_dns_zone_group {
    name                 = "pdzg-${azurerm_cosmosdb_account.this.name}"
    private_dns_zone_ids = [azurerm_private_dns_zone.this.id]
  }

  private_service_connection {
    name                           = "psc-${azurerm_cosmosdb_account.this.name}"
    is_manual_connection           = var.is_manual_connection
    private_connection_resource_id = azurerm_cosmosdb_account.this.id
    subresource_names              = var.subresource_names
    request_message                = var.is_manual_connection ? var.request_message : null
  }
  dynamic "ip_configuration" {
    for_each = var.ip_configuration
    content {
      name               = ip_configuration.value.name
      private_ip_address = ip_configuration.value.private_ip_address
      subresource_name   = ip_configuration.value.subresource_name
      member_name        = ip_configuration.value.member_name
    }
  }
  tags = merge(var.general_tags, var.private_endpoint_tags)
  timeouts {
    create = var.private_endpoint_timeouts.create
    update = var.private_endpoint_timeouts.update
    read   = var.private_endpoint_timeouts.read
    delete = var.private_endpoint_timeouts.delete
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone
# https://learn.microsoft.com/en-us/azure/cosmos-db/how-to-configure-private-endpoints?tabs=arm-bicep#private-zone-name-mapping
# https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-dns
resource "azurerm_private_dns_zone" "this" {
  name                = format("%s.privatelink.mongo.cosmos.azure.com", lower(azurerm_cosmosdb_account.this.name))
  resource_group_name = azurerm_cosmosdb_account.this.resource_group_name
  dynamic "soa_record" {
    for_each = var.soa_record
    content {
      email        = soa_record.value.email
      expire_time  = soa_record.value.expire_time
      minimum_ttl  = soa_record.value.minimum_ttl
      refresh_time = soa_record.value.refresh_time
      retry_time   = soa_record.value.retry_time
      ttl          = soa_record.value.ttl
      tags         = merge(var.general_tags, soa_record.value.tags)
    }
  }
  tags = merge(var.general_tags, var.private_dns_zone_tags)
  timeouts {
    create = var.private_dns_zone_timeouts.create
    update = var.private_dns_zone_timeouts.update
    read   = var.private_dns_zone_timeouts.read
    delete = var.private_dns_zone_timeouts.delete
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link
resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  name                  = azurerm_cosmosdb_account.this.name
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  resource_group_name   = azurerm_cosmosdb_account.this.resource_group_name
  virtual_network_id    = data.azurerm_virtual_network.vnet.id
  registration_enabled  = var.registration_enabled
  tags                  = merge(var.general_tags, var.private_dns_zone_virtual_network_link_tags)
  timeouts {
    create = var.private_dns_zone_virtual_network_link_timeouts.create
    update = var.private_dns_zone_virtual_network_link_timeouts.update
    read   = var.private_dns_zone_virtual_network_link_timeouts.read
    delete = var.private_dns_zone_virtual_network_link_timeouts.delete
  }
}
