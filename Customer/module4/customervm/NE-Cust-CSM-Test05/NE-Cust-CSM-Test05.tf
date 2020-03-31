# Set subscription Id

provider "azurerm" {
  subscription_id = "905ad2a3-2cff-494a-8e9b-73c48fcd96aa"
}
# adding variable first variable for resource group and second variable for virtual machine (server)
variable "CustomerCode" { 
  description = "Enter a unique, *lower-case* letter ID to identify customer resource group."
}

variable "virtual_machine_name" { 
  description = "Enter a unique, *lower-case* letter ID to identify customer resources Example: NE-customercode."
}

variable "customer_Vnet_resourcegroup_name" { 
  description = "Enter a unique, *lower-case* letter ID to identify customer resources Example: customer vnet resource group name"
}

# refer to a resource group
 resource "azurerm_resource_group" "customer" {
  name = "${var.CustomerCode}-RG"
  location    = "North europe"
}

#refer to a subnet
data "azurerm_subnet" "customer" {
  name                           = "subnet1"
  virtual_network_name           = "Azure-NorthernEurope-LoadBalancer-Vnet"
  resource_group_name            = "${var.customer_Vnet_resourcegroup_name}-RG"
}

# create a network interface
resource "azurerm_network_interface" "customer" {
  name                            = "${var.virtual_machine_name}-CSM-Test05nic"
  location                        = "${azurerm_resource_group.customer.location}"
  resource_group_name             = "${azurerm_resource_group.customer.name}"

  ip_configuration {
    name                          = "${var.virtual_machine_name}-CSM-Test05ipconfig"
    subnet_id                     = "${data.azurerm_subnet.customer.id}"
    private_ip_address_allocation = "dynamic"
  }
}


# Calling  packer image

data  "azurerm_image" "customer" {

  name = "Azure-ws2012r2-CSM"
  resource_group_name             = "AZ-PACKER-RG"
}

# Create virtual machine
resource   "azurerm_virtual_machine" "customer" {
    name                         = "${var.virtual_machine_name}-CSM-Test05"
    location                     = "${azurerm_network_interface.customer.location}"
    resource_group_name          = "${azurerm_resource_group.customer.name}"
    network_interface_ids        = ["${azurerm_network_interface.customer.id}"]
    vm_size                      = "Standard_D2_v3"

    


    storage_image_reference {
   id = "${data.azurerm_image.customer.id}"
}
    storage_os_disk {
    name                         = "${var.virtual_machine_name}CSM-Test05osdisk"
    managed_disk_type            = "Standard_LRS"
    caching                      = "ReadWrite"
    create_option                = "FromImage"
  }
  
  # machine credentials
  
  os_profile {
    computer_name                = "CSMTest05"
    admin_username               = "CSMTest05"
    admin_password               = "RV72jXJFGGfh"
  }

           

os_profile_windows_config {
enable_automatic_upgrades        = "true"
provision_vm_agent               ="true"
}

}
