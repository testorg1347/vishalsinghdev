provider "azurerm" {
  subscription_id = "905ad2a3-2cff-494a-8e9b-73c48fcd96aa"
}

//adding variable to add customer resource name
variable "CustomerCode" {
    description = "Enter a unique, *lower-case* letter ID to identify customer resources."
  }

//Create a resource group
resource "azurerm_resource_group" "Customer11" {
  name     = "${var.CustomerCode}-RG"
  location = "North europe"
}


//Create a nsg
resource "azurerm_network_security_group" "Customernsg1" {
  name                = "${var.CustomerCode}nsg1"
  location            = "${azurerm_resource_group.Customer11.location}"
  resource_group_name = "${azurerm_resource_group.Customer11.name}"
}

resource "azurerm_network_security_group" "Customernsg2" {
  name                = "${var.CustomerCode}nsg2"
  location            = "${azurerm_resource_group.Customer11.location}"
  resource_group_name = "${azurerm_resource_group.Customer11.name}"
}

resource "azurerm_network_security_group" "Customernsg3" {
  name                = "${var.CustomerCode}nsg3"
  location            = "${azurerm_resource_group.Customer11.location}"
  resource_group_name = "${azurerm_resource_group.Customer11.name}"
}

//Create a Virtual Network
resource "azurerm_virtual_network" "CustomerVnet" {
  name                = "Azure-NorthernEurope-LoadBalancer-Vnet"
  location            = "${azurerm_resource_group.Customer11.location}"
  resource_group_name = "${azurerm_resource_group.Customer11.name}"
  address_space       = ["10.80.13.0/24"] //Define Address Space for vnet
  
//Create a Subnet

  subnet {
    name           = "subnet1"
    address_prefix = "10.80.13.0/26" //Define Address prefix for subnet
    security_group = "${azurerm_network_security_group.Customernsg1.id}"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.80.13.64/26" //Define Address prefix for subnet
    security_group = "${azurerm_network_security_group.Customernsg2.id}"
  }

  subnet {
    name           = "Application-Gateway-Subnet"
    address_prefix = "10.80.13.128/27" //Define Address prefix for Application Gateway subnet
    security_group = "${azurerm_network_security_group.Customernsg3.id}"
  }
}