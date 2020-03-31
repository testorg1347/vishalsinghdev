
#--- CALLLING MODULES

# Define variable

variable "CustomerCode" { 
  description = "Enter a unique, *lower-case*letter ID to identify customer resource group."
}

variable "virtual_machine_name" { 
  description = "Enter a unique, *lower-case*letter ID to identify customer resources Example: NE-customercode."
}

  variable "customer_Vnet_resourcegroup_name" { 
  description = "Enter a unique, *lower-case* letter ID to identify customer resources Example: customer vnet resource group name"
  }
#---- Calling virtual machines ---#

  module "NE-Cust-CAM-Test01" {
    source                      = "./CAMvm/NE-Cust-CAM-Test01"
    CustomerCode                = "${var.CustomerCode}"
    virtual_machine_name        = "${var.virtual_machine_name }"
    customer_Vnet_resourcegroup_name              ="${var.customer_Vnet_resourcegroup_name}"

  }

  module "NE-Cust-CAM-Test02" {
    source                      = "./CAMvm/NE-Cust-CAM-Test02"
    CustomerCode                = "${var.CustomerCode}"
    virtual_machine_name        = "${var.virtual_machine_name }"
    customer_Vnet_resourcegroup_name              ="${var.customer_Vnet_resourcegroup_name}"

  }

#---- CaLLING Database ---#
module "NE-HA-S12-CAM-Test-101" {
    source                      = "./CAMvm/NE-HA-S12-CAM-Test-101"
    CustomerCode                = "${var.CustomerCode}"

  }