
provider "azurerm" {
  subscription_id = "905ad2a3-2cff-494a-8e9b-73c48fcd96aa"
}
//adding variable to add customer resource name
variable "CustomerCode" { 
  description = "Enter a unique, *lower-case* two-letter ID to identify customer resources"
}
// Calling resource group and both Virtual Network 

data "azurerm_resource_group" "Customerr" {
  name     = "AZ-AdminVNET-RG"
 
}
data "azurerm_resource_group" "Custome" {
  name     = "${var.CustomerCode}-RG"
}

data "azurerm_virtual_network" "Customer" {
  name = "Azure-NorthernEurope-LoadBalancer-Vnet"
  resource_group_name = "${data.azurerm_resource_group.Custome.name}"
}

data "azurerm_virtual_network" "Customer1" {
  name  = "Azure-NorthernEurope-ADMIN-VNET"
  resource_group_name = "${data.azurerm_resource_group.Customerr.name}"
 
  
}


//peering loadBalancerVnet and adminvnet
resource "azurerm_virtual_network_peering" "Customer" {
  name                         = "loadbalancer-admin"
  virtual_network_name         = "Azure-NorthernEurope-LoadBalancer-Vnet"
  remote_virtual_network_id    = "${data.azurerm_virtual_network.Customer1.id}"
  resource_group_name          = "${data.azurerm_resource_group.Custome.name}"
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "block" {
  name                         = "admin-loadbalancer"
  virtual_network_name         = "Azure-NorthernEurope-ADMIN-VNET"
  remote_virtual_network_id  = "${data.azurerm_virtual_network.Customer.id}"
  resource_group_name        = "${data.azurerm_resource_group.Customerr.name}"
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}





