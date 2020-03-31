
#--- CALLLING MODULES

# Define variable

variable "CustomerCode" { 
  description = "Enter a unique, *lower-case*letter ID to identify customer resource group(Enter the same code while created resource group)."
}

variable "virtual_machine_name" { 
  description = "Enter a unique, *lower-case* letter ID to identify customer resources Example: NE-customercode.(enter same name which assigned to the virtual machines)"
}

variable "customer_vnet_resource_group" { 
}

#---- Application Gateway ---#

   module "Azure-NorthernEurope-CAM-ApplicationGateway" {
    source                      = "./applicationGateway/Azure-NorthernEurope-CAM-ApplicationGateway"
    CustomerCode                = "${var.CustomerCode}"
    virtual_machine_name        = "${var.virtual_machine_name }"
    customer_vnet_resource_group = "${var.customer_vnet_resource_group}"

  }

  