variable "general_tags" {
  description = "General tags to be merged with the tags of each resource."
  type        = map(string)
  default     = {}
}

variable "cosmosdb_account_name" {
  description = "The name of the Cosmos DB Account."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Cosmos DB Account."
  type        = string
}

variable "cosmosdb_account_location" {
  description = "Specifies the supported Azure location where the resource exists."
  type        = string
}

variable "offer_type" {
  description = "The offer type to provide Cosmos DB Account."
  type        = string
  default     = "Standard"
}

variable "consistency_level" {
  description = "The consistency level of the Cosmos DB Account."
  type        = string
  default     = "Session"
}

variable "max_interval_in_seconds" {
  description = "The maximum interval in seconds."
  type        = number
  default     = 5
}

variable "max_staleness_prefix" {
  description = "The maximum staleness prefix."
  type        = number
  default     = 100
}

variable "geo_locations" {
  description = "Specifies the supported Azure locations for the geo-replication."
  type = list(object({
    location          = string
    failover_priority = number
    zone_redundant    = optional(bool, false)
  }))
  default = []
}

variable "schema_type" {
  description = "The schema type of the analytical storage of Cosmos DB Account."
  type        = string
  default     = "WellDefined"
}

variable "total_throughput_limit" {
  description = "The total throughput limit of the Cosmos DB Account."
  type        = number
  default     = -1
}

variable "create_mode" {
  description = "The create mode of the Cosmos DB Account."
  type        = string
  default     = "Default"
}

variable "default_identity_type" {
  description = "The default identity type of the Cosmos DB Account."
  type        = string
  default     = "FirstPartyIdentity"
}

variable "kind" {
  description = "The kind of the Cosmos DB Account."
  type        = string
  default     = "MongoDB"
}

variable "ip_range_filter" {
  description = "The IP range filter for the Cosmos DB Account."
  type        = string
  default     = ""
}

variable "enable_free_tier" {
  description = "Whether the free tier is enabled for the Cosmos DB Account."
  type        = bool
  default     = false
}

variable "analytical_storage_enabled" {
  description = "Whether analytical storage is enabled for the Cosmos DB Account."
  type        = bool
  default     = false
}

variable "enable_automatic_failover" {
  description = "Whether automatic failover is enabled for the Cosmos DB Account."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled for the Cosmos DB Account."
  type        = bool
  default     = false
}

variable "capabilities" {
  description = "The capabilities which should be enabled for this Cosmos DB account."
  type        = list(string)
  default     = []
}

variable "is_virtual_network_filter_enabled" {
  description = "Whether the virtual network filter is enabled for the Cosmos DB Account."
  type        = bool
  default     = null
}

variable "key_vault_key_id" {
  description = "The ID of the Key Vault key for the Cosmos DB Account."
  type        = string
  default     = null
}

variable "virtual_network_rules" {
  description = "Specifies virtual_network_rules resources, used to define which subnets are allowed to access this CosmosDB account."
  type = list(object({
    id                                   = string
    ignore_missing_vnet_service_endpoint = optional(bool)
  }))
  default = []
}

variable "enable_multiple_write_locations" {
  description = "Whether multiple write locations are enabled for the Cosmos DB Account."
  type        = bool
  default     = null
}

variable "access_key_metadata_writes_enabled" {
  description = "Whether access key metadata writes are enabled for the Cosmos DB Account."
  type        = bool
  default     = true
}

variable "mongo_server_version" {
  description = "The MongoDB server version for the Cosmos DB Account."
  type        = string
  default     = null
}

variable "network_acl_bypass_for_azure_services" {
  description = "Whether network ACL bypass for Azure services is enabled for the Cosmos DB Account."
  type        = bool
  default     = false
}

variable "network_acl_bypass_ids" {
  description = "The network ACL bypass IDs for the Cosmos DB Account."
  type        = list(string)
  default     = []
}

variable "local_authentication_disabled" {
  description = "Whether local authentication is disabled for the Cosmos DB Account."
  type        = bool
  default     = false
}

variable "cosmosdb_account_backup" {
  description = "A backup for the Cosmos DB Account."
  type = list(object({
    type                = string
    interval_in_minutes = optional(number)
    retention_in_hours  = optional(number)
    storage_redundancy  = optional(string)
  }))
  default = []
}

variable "cosmosdb_account_cors_rule" {
  description = "CORS rule for the Cosmos DB Account."
  type = list(object({
    allowed_headers    = list(string)
    allowed_methods    = list(string)
    allowed_origins    = list(string)
    exposed_headers    = list(string)
    max_age_in_seconds = optional(number)
  }))
  default = []
}

variable "cosmosdb_account_identity" {
  description = "Identity for the Cosmos DB Account."
  type = list(object({
    type         = string
    identity_ids = optional(list(string))
  }))
  default = []
}

variable "cosmosdb_account_restore" {
  description = "Restore for the Cosmos DB Account."
  type = list(object({
    source_cosmosdb_account_id = string
    restore_timestamp_in_utc   = string
    database = optional(list(object({
      name             = string
      collection_names = optional(list(string))
    })))
  }))
  default = []
}

variable "cosmosdb_account_tags" {
  description = "The tags specifically for the Cosmos DB Account."
  type        = map(string)
  default     = {}
}

variable "cosmosdb_account_timeouts" {
  description = "Timeouts for the Cosmos DB Account."
  type        = map(string)
  default = {
    create = "180m"
    update = "180m"
    read   = "5m"
    delete = "180m"
  }
}

variable "cosmosdb_mongo_databases" {
  description = "A map defining the properties of the CosmosDB Mongo Database(s)."
  type = map(object({
    name       = string
    throughput = optional(number)
    autoscale_settings = optional(list(object({
      max_throughput = number
    })), [])
  }))
}

variable "cosmosdb_mongo_database_timeouts" {
  description = "Timeouts for the CosmosDB Mongo Database."
  type        = map(string)
  default = {
    create = "30m"
    update = "30m"
    read   = "5m"
    delete = "30m"
  }
}

variable "subnet_name" {
  description = "The name of the subnet where the Private Endpoint will be linked."
  type        = string
}

variable "custom_network_interface_name" {
  description = "The name of the network interface associated with the private endpoint."
  type        = string
  default     = null
}

variable "is_manual_connection" {
  description = "A flag indicating if the private endpoint connection is manual."
  type        = bool
  default     = false
}

variable "subresource_names" {
  description = "The list of subresource names which the Private Endpoint is able to connect to."
  type        = list(string)
  default     = ["MongoDB"]
}

variable "request_message" {
  description = "The request message for the private endpoint connection."
  type        = string
  default     = null
}

variable "ip_configuration" {
  description = "A collection of IP configuration for the private endpoint."
  type = list(object({
    name               = string
    private_ip_address = string
    subresource_name   = optional(string)
    member_name        = optional(string)
  }))
  default = []
}

variable "private_endpoint_tags" {
  description = "A map of tags to assign to the private endpoint."
  type        = map(string)
  default     = {}
}

variable "private_endpoint_timeouts" {
  description = "Timeout settings for the private endpoint."
  type        = map(string)
  default = {
    create = "60m"
    update = "60m"
    read   = "5m"
    delete = "60m"
  }
}

variable "soa_record" {
  description = "A collection of Start of Authority (SOA) record properties."
  type = list(object({
    email        = string
    expire_time  = optional(number, 2419200)
    minimum_ttl  = optional(number, 10)
    refresh_time = optional(number, 3600)
    retry_time   = optional(number, 300)
    ttl          = optional(number, 3600)
    tags         = optional(map(string))
  }))
  default = []
}

variable "private_dns_zone_tags" {
  description = "A map of tags to assign to the private DNS zone."
  type        = map(string)
  default     = {}
}

variable "private_dns_zone_timeouts" {
  description = "Timeout settings for the private DNS zone."
  type        = map(string)
  default = {
    create = "30m"
    update = "30m"
    read   = "5m"
    delete = "30m"
  }
}

variable "virtual_network_name" {
  description = "The name of the Virtual Network for DNS resolution."
  type        = string
}

variable "registration_enabled" {
  description = "A flag indicating if auto-registration of virtual machine records in the DNS zone is enabled."
  type        = bool
  default     = true
}

variable "private_dns_zone_virtual_network_link_tags" {
  description = "A map of tags to assign to the virtual network link."
  type        = map(string)
  default     = {}
}

variable "private_dns_zone_virtual_network_link_timeouts" {
  description = "Timeout settings for the private DNS zone virtual network link."
  type        = map(string)
  default = {
    create = "30m"
    update = "30m"
    read   = "5m"
    delete = "30m"
  }
}
