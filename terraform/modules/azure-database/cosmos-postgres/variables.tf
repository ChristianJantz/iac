variable "cosmos_postgres_name" {
    type = string
    description = "Name für den Azure Cosmos postgres DB"
}
variable "rg_name" {
    type = string
    description = "Name der Ressourcengruppe"
}
variable "location" {
    type = string
    description = "Region der Azure Ressource"
}
variable "citus_version" {
    type = string
    description = "Die Citus Version für die Verwaltung"
    default = "11.3"
}
variable "postgres_sql_version" {
    type = string
    default = "14"
    description = "Postgres Sql Version Default ist 14"
}
variable "node_count" {
    type = number
    description = "Number of the Nodes. Der muss zwischen 0 und 20 liegen"
    default = 2
}
variable "postgres_admin_pw" {
    type = string
    description = "Passwort für die Citus Admin Default ist Test@cor3"
    default = "Test@cor3"
}
variable "coordinator_storage_quota_in_mb" {
    type = number
    description = "Gibt die Speichergröße in MB an. Mögliche werte sind 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, 16777216"
    default = 524288
}
variable "coordinator_vcore_count" {
    type = number
    description = "Die Kerngröße für das Postgres Cluster sind 1, 2, 4, 8, 16, 32, 64, 96. Der Default ist 4"
    default = 4
}
variable "coordinator_server_edition" {
    type = string
    description = "Art des Servers. Mögliche Arten sind BurstableGeneralPurpose, BurstableMemoryOptimized, GeneralPurpose and MemoryOptimized. Der Default ist GeneralPurpose"
    default = "GeneralPurpose"
}
variable "node_vcores" {
    type = number
    description = "Der Kern auf jeder Worker Node. Mögliche Werte 1, 2, 4, 8, 16, 32, 64, 96, 104. Default ist 1"
    default = 4
}
variable "node_server_edition" {
    type = string
    description = "Die Art der Worker Nodes. Mögliche Arten sind BurstableGeneralPurpose, BurstableMemoryOptimized, GeneralPurpose and MemoryOptimized. Default ist MemoryOptimized."
    default = "MemoryOptimized"
}
variable "node_storage_quota_in_mb" {
    type = number
    description = "value"
    default = 524288

}
# variable "source_location" {
#     type = string
#     description = "Gib die Region für die  Replikations an "
#     default = ""
# }
variable "tags" {
    type = map(string)
    description = "Tags der Resource"
    default = {}
}