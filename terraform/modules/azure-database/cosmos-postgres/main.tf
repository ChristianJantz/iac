resource "azurerm_cosmosdb_postgresql_cluster" "cosmos_postgres" {
    name = var.cosmos_postgres_name
    location = var.location
    resource_group_name = var.rg_name
    tags = var.tags
    # Coordinator Configuration
    citus_version = var.citus_version
    coordinator_public_ip_access_enabled = true
    coordinator_storage_quota_in_mb = var.coordinator_storage_quota_in_mb
    coordinator_server_edition = var.coordinator_server_edition
    coordinator_vcore_count = var.coordinator_vcore_count
    # node Configuration
    node_count = var.node_count
    node_vcores = var.node_vcores
    node_server_edition = var.node_server_edition
    node_storage_quota_in_mb = var.node_storage_quota_in_mb
    node_public_ip_access_enabled = false
    administrator_login_password = var.postgres_admin_pw
    sql_version = var.postgres_sql_version
    
    #source_location = var.source_location

    
}
resource "azurerm_cosmosdb_postgresql_firewall_rule" "cosmos_postgres_fr" {
    name = "${lower(var.cosmos_postgres_name)}-rule"
    cluster_id = azurerm_cosmosdb_postgresql_cluster.cosmos_postgres.id
    start_ip_address = "0.0.0.0"
    end_ip_address = "0.0.0.0"
}