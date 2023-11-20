variable "public_ip_name" {
    type = string
    description = "Name der Public Ip Adresse"
}
variable "resource_location" {
    type = string
    description = "Lokation der Azure Resource"
}
variable "rg_name" {
    type = string
    description = "Name der Ressourcengruppe"
}
variable "tags" {
    type = map(string)
    description = "Tags der Resource"
    default = {}
}