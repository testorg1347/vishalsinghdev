
provider "azurerm" {
  subscription_id = "905ad2a3-2cff-494a-8e9b-73c48fcd96aa"
}

variable "CustomerCode" { 
  description = "Enter a unique, *lower-case* two-letter ID to identify customer resources"
}

resource "azurerm_resource_group" "customer" {
  name     = "${var.CustomerCode}-RG"
  location                     = "North europe"
}

resource "azurerm_sql_server" "customer" {
  name                         = "azcsmqaserver4"
  resource_group_name          = "${azurerm_resource_group.customer.name}"
  location                     = "North europe"
  version                      = "12.0"
  administrator_login          = "CSMAdmin"
  administrator_login_password = "RV72jXJFGGfh"
}

resource "azurerm_sql_database" "Customer" {
  name                = "NE-HA-S12-CSM-Test-104"
  resource_group_name = "${azurerm_resource_group.customer.name}"
  location            = "North europe"
  server_name         = "${azurerm_sql_server.customer.name}"

  tags = {
    environment = "production-team"
  }
}