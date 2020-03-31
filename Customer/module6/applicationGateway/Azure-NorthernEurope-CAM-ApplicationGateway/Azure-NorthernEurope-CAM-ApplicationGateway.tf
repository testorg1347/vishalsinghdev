
provider "azurerm" {
  subscription_id = "905ad2a3-2cff-494a-8e9b-73c48fcd96aa"
}
# Creating Variable
variable "CustomerCode" { 
  description = "Enter a unique, *lower-case*letter ID to identify customer resource group(Enter the same code while created resource group)."
}

variable "virtual_machine_name" { 
  description = "Enter a unique, *lower-case* letter ID to identify customer resources Example: NE-customercode.(enter same name which assigned to the virtual machines)"
}

variable "customer_vnet_resource_group" { 
}


# Calling a resource group
data "azurerm_resource_group" "customer" {
  name                   = "${var.CustomerCode}-RG"
}

# Calling Virtual Network
data "azurerm_virtual_network" "vnet" {
  name                   = "Azure-NorthernEurope-LoadBalancer-Vnet"
  resource_group_name  = "${var.customer_vnet_resource_group}"
}

data "azurerm_subnet" "customer" {
  name                   = "Application-Gateway-Subnet"
  virtual_network_name   = "Azure-NorthernEurope-LoadBalancer-Vnet"
  resource_group_name  = "${var.customer_vnet_resource_group}"

}

#Existing NIC for backend ip
data "azurerm_network_interface" "customer" {
  name                   = "${var.virtual_machine_name}-CAM-Test01nic"
  resource_group_name    = "${data.azurerm_resource_group.customer.name}"

}


data "azurerm_network_interface" "customerr" {
  name                   = "${var.virtual_machine_name}-CAM-Test02nic"
  resource_group_name    = "${data.azurerm_resource_group.customer.name}"
}


   

# Create public-ip

resource "azurerm_public_ip" "pip" {
  name                         = "CAM-ApplicationGateway-public-ip"
  resource_group_name          = "${data.azurerm_resource_group.customer.name}"
  location                     = "${data.azurerm_resource_group.customer.location}"
  allocation_method            = "Dynamic"
}

# Create an application gateway
resource "azurerm_application_gateway" "customer" {
  name                         = "Azure-NorthernEurope-CAM-ApplicationGateway"
  resource_group_name          = "${data.azurerm_resource_group.customer.name}"
  location                     = "${data.azurerm_resource_group.customer.location}"

  sku {
    name                       = "Standard_Small"
    tier                       = "Standard"
    capacity                   = 2
  }

  gateway_ip_configuration {
      name                     = "gateway-ip-configuration"
      subnet_id                = "${data.azurerm_virtual_network.vnet.id}/subnets/${data.azurerm_subnet.customer.name}"
  }

  frontend_port {
      name                     = "feport"
      port                     = 80
  }

  frontend_ip_configuration {
      name                     = "fip"
      public_ip_address_id     = "${azurerm_public_ip.pip.id}"
  }

 backend_address_pool {
      name                     = "backendaddresspool"
    ip_addresses               = ["${data.azurerm_network_interface.customer.private_ip_address}"]

  }

   backend_address_pool {
      name                     = "backendaddresspool1"
  ip_addresses                 = ["${data.azurerm_network_interface.customerr.private_ip_address}"]
  }
  

  backend_http_settings {
      name                     = "backendhttpsettings"
      cookie_based_affinity    = "Disabled"
      port                     = 80
      protocol                 = "Http"
     request_timeout           = 1
  }

  http_listener {
        name                            = "httplistener"
        frontend_ip_configuration_name  = "fip"
        frontend_port_name              = "feport"
        protocol                        = "Http"
  }

  request_routing_rule {
          name                          = "rqrt"
          rule_type                     = "Basic"
          http_listener_name            = "httplistener"
          backend_address_pool_name     = "backendaddresspool"
          backend_http_settings_name    = "backendhttpsettings"
  }
}

