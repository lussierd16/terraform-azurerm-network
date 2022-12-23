terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.26.0"
    }
  }
}
provider "azurerm" {
  features {}
}

# variables
variable "name" {
  description = "A name for route"
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group in which to create the route."
  type        = string
}
variable "route_table_name" {
  description = "The name of the route table within which create the route. Changing this forces a new resource to be created."
  type        = string
}
variable "address_prefix" {
  description = "The destination to which the route applies. Can be CIDR (such as 10.1.0.0/16) or Azure Service Tag (such as ApiManagement, AzureBackup or AzureMonitor) format."
  type        = string
}
variable "next_hop_type" {
  description = "The type of Azure hop the packet should be sent to. Possible values are VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None."
  type        = string
}
variable "next_hop_in_ip_address" {
  description = "Contains the IP address packets should be forwarded to. Next hop values are only allowed in routes where the next hop type is VirtualAppliance."
  type        = string
}
# resources
# route
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route
resource "azurerm_route" "this" {
  name                   = var.name
  resource_group_name    = var.resource_group_name
  route_table_name       = var.route_table_name
  address_prefix         = var.address_prefix
  next_hop_type          = var.next_hop_type
  next_hop_in_ip_address = try(lower(var.next_hop_type), null) == "virtualappliance" ? var.next_hop_in_ip_address : null
}

# outputs