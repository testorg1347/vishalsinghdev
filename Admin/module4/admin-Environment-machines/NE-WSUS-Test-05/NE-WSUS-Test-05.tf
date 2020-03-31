# Set subscription ID 

provider "azurerm" {
  subscription_id = "905ad2a3-2cff-494a-8e9b-73c48fcd96aa"
}

# refer to a resource group
resource "azurerm_resource_group" "customer" {
  name     = "AZ-AdminServer-RG"
  location = "North europe"
}

#refer to a subnet
data "azurerm_subnet" "customer" {
  name                 = "Server_Subnet"
  virtual_network_name = "Azure-NorthernEurope-ADMIN-VNET"
  resource_group_name  = "AZ-AdminVNET-RG"
}


# create a network interface
resource "azurerm_network_interface" "customer" {
  name                            = "NE-WSUS-Test-01"
  location                        = "${azurerm_resource_group.customer.location}"
  resource_group_name             = "${azurerm_resource_group.customer.name}"

  ip_configuration {
    name                          = "NE-WSUS-Test-01-ipconfig"
    subnet_id                     = "${data.azurerm_subnet.customer.id}"
    private_ip_address_allocation = "dynamic"
  }
}


resource "azurerm_virtual_machine" "customer" {
  name                  = "NE-WSUS-Test-01"
 location               = "${azurerm_network_interface.customer.location}"
 resource_group_name    = "${azurerm_resource_group.customer.name}"
 network_interface_ids  = ["${azurerm_network_interface.customer.id}"]
  vm_size               = "Standard_D2_v3"

  storage_image_reference {
    publisher           = "MicrosoftWindowsServer"
    offer               = "WindowsServer"
    sku                 = "2016-Datacenter"
    version             = "latest"
  }

  storage_os_disk {
    name               = "NE-WSUS-Test-01_OsDisk"
    caching            = "ReadWrite"
    create_option      = "FromImage"
    managed_disk_type  = "Standard_LRS"
  }

  os_profile {
    computer_name      = "NE-WSUS-Test-01"
    admin_username     = "AdminWSUS"
    admin_password     = "RV72jXJFGGfh"

  }

  os_profile_windows_config {
  }
}
