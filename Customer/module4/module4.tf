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
   module "NE-Cust-CSM-Test01" {
    source                      = "./customervm/NE-Cust-CSM-Test01"
    CustomerCode                = "${var.CustomerCode}"
    virtual_machine_name        = "${var.virtual_machine_name }"
    customer_Vnet_resourcegroup_name= "${var.customer_Vnet_resourcegroup_name }"

  }

  module "NE-Cust-CSM-Test02" {
    source                      = "./customervm/NE-Cust-CSM-Test02"
    CustomerCode                = "${var.CustomerCode}"
    virtual_machine_name        = "${var.virtual_machine_name }"
    customer_Vnet_resourcegroup_name = "${var.customer_Vnet_resourcegroup_name }"

  }

   module "NE-Cust-CSM-Test03" {
    source                      = "./customervm/NE-Cust-CSM-Test03"
    CustomerCode                = "${var.CustomerCode}"
    virtual_machine_name        = "${var.virtual_machine_name }"
    customer_Vnet_resourcegroup_name = "${var.customer_Vnet_resourcegroup_name }"

  }

   module "NE-Cust-CSM-Test04" {
    source                      = "./customervm/NE-Cust-CSM-Test04"
    CustomerCode                = "${var.CustomerCode}"
    virtual_machine_name        = "${var.virtual_machine_name }"
    customer_Vnet_resourcegroup_name = "${var.customer_Vnet_resourcegroup_name }"

  }

   module "NE-Cust-CSM-Test05" {
    source                      = "./customervm/NE-Cust-CSM-Test05"
    CustomerCode                = "${var.CustomerCode}"
    virtual_machine_name        = "${var.virtual_machine_name }"
    customer_Vnet_resourcegroup_name = "${var.customer_Vnet_resourcegroup_name }"

  }
 