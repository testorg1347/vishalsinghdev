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

# Create public IP
resource "azurerm_public_ip" "customer" {
    name                         = "NEBastTest01-PublicIP"
    location                     = "${azurerm_resource_group.customer.location}"
    resource_group_name          = "${azurerm_resource_group.customer.name}"
    allocation_method            = "Dynamic"

}

# create a network interface
resource "azurerm_network_interface" "customer" {
  name                            = "NE-Bast-Test01"
  location                        = "${azurerm_resource_group.customer.location}"
  resource_group_name             = "${azurerm_resource_group.customer.name}"

  ip_configuration {
    name                          = "NE-Bast-Test-01-ipconfig"
    subnet_id                     = "${data.azurerm_subnet.customer.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${azurerm_public_ip.customer.id}"
  }
}

# Create virtual machine
resource "azurerm_virtual_machine" "customer" {
    name                  = "NE-Bast-Test-01"
    location              = "${azurerm_network_interface.customer.location}"
    resource_group_name   = "${azurerm_resource_group.customer.name}"
    network_interface_ids = ["${azurerm_network_interface.customer.id}"]
    vm_size               = "Standard_D2_v3"

    os_profile_windows_config {
  provision_vm_agent = true
}


  storage_image_reference {
    publisher          = "MicrosoftWindowsServer"
    offer              = "WindowsServer"
    sku                = "2016-Datacenter"
    version            = "latest"
  }
   storage_os_disk {
    name               = "NE-Bast-Test01_OsDisk"
    caching            = "ReadWrite"
    create_option      = "FromImage"
    managed_disk_type  = "Standard_LRS"
  }
   os_profile {
    computer_name      = "NE-Bast-Test-01"
    admin_username     = "AdminBast"
    admin_password     = "RV72jXJFGGfh"
  }

}

