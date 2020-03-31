
provider "azurerm" {
  subscription_id = "905ad2a3-2cff-494a-8e9b-73c48fcd96aa"
}
//Create a resource group and nsg

resource "azurerm_resource_group" "Customer" {
  name     = "AZ-AdminVNET-RG"
  location = "North europe"
}

resource "azurerm_network_security_group" "Customernsg01" {
  name                = "Server-Subnet-NSG"
  location            = "${azurerm_resource_group.Customer.location}"
  resource_group_name = "${azurerm_resource_group.Customer.name}"
}



//Create a Vnet

resource "azurerm_virtual_network" "Customer" {
  name                = "Azure-NorthernEurope-ADMIN-VNET"
  location            = "${azurerm_resource_group.Customer.location}"
  resource_group_name = "${azurerm_resource_group.Customer.name}"
  address_space       = ["10.80.12.0/24"] //Define Address Space for vnet


  //Create a  Subnet

  subnet {
    name           = "server_subnet"
    address_prefix = "10.80.12.0/25" //Define Address prefix for subnet
    security_group = "${azurerm_network_security_group.Customernsg01.id}"
  }


  subnet {
    name           = "GatewaySubnet"
    address_prefix = "10.80.12.128/28" //Define Address prefix for subnet
  }
}