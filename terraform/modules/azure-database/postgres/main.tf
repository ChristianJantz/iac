# private DNS ZONE
resource "azurerm_private_dns_zone" "postgresdns" {
    name = "${lower(var.server_name)}-pdz.postgres.database.azure.com"
    resource_group_name = var.resource_group_name
    tags = var.tags
    
}

# Link private DNS to Vnet
resource "azurerm_private_dns_zone_virtual_network_link" "postgres_dns_vnet_link" {
    depends_on = [ azurerm_private_dns_zone.postgresdns ]
    name = "${lower(var.server_name)}-pdzvnetlink.com"
    private_dns_zone_name = azurerm_private_dns_zone.postgresdns.name
    virtual_network_id = var.psql_vnet_id
    registration_enabled = true
    resource_group_name = azurerm_postgresql_flexible_server.default.resource_group_name
    tags = var.tags
}

# flexsible postgres sever 
resource "azurerm_postgresql_flexible_server" "default" {
    depends_on = [ azurerm_private_dns_zone.postgresdns ]
    name = var.server_name
    resource_group_name = var.resource_group_name
    location = var.location
    administrator_login = var.administrator_login
    administrator_password = var.administrator_login_password
    delegated_subnet_id = var.delegated_subnet_id
    private_dns_zone_id = azurerm_private_dns_zone.postgresdns.id
    sku_name = var.sku_name
    version = var.postgres_version
    storage_mb = var.storage_mb
    backup_retention_days = var.backup_retention_days
    geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
    zone = var.psql_zone
    tags = var.tags
}

# initial database
resource "azurerm_postgresql_flexible_server_database" "default" {
    depends_on = [ azurerm_postgresql_flexible_server.default ]
    name = lower("${trim(var.server_name, "-")}_db")
    server_id = azurerm_postgresql_flexible_server.default.id
    collation = "en_US.utf8"
    charset = "UTF8"
}