provider "azurerm" {
  subscription_id = "905ad2a3-2cff-494a-8e9b-73c48fcd96aa"
}

# refer to a resource group
data "azurerm_resource_group" "customer" {
  name                 = "AZ-AdminVNET-RG"
}

#refer to a subnet
data "azurerm_subnet" "customer" {
  name                 = "Gatewaysubnet"
  virtual_network_name = "Azure-NorthernEurope-ADMIN-VNET"
  resource_group_name  = "AZ-AdminVNET-RG"
}

# Create public IPs
resource "azurerm_public_ip" "customer" {
  name                = "Azure-NorthernEurope-VPNGateway-publicip"
  location            = "${data.azurerm_resource_group.customer.location}"
  resource_group_name = "${data.azurerm_resource_group.customer.name}"
  allocation_method   = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "customer" {
  name                            = "Azure-NorthernEurope-VPNGateway"
  location                        = "${data.azurerm_resource_group.customer.location}"
  resource_group_name             = "${data.azurerm_resource_group.customer.name}"

  type                            = "Vpn"
  vpn_type                        = "RouteBased"

  active_active                   = false
  enable_bgp                      = false
  sku                             = "Basic"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = "${azurerm_public_ip.customer.id}"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = "${data.azurerm_subnet.customer.id}"

  }
}
