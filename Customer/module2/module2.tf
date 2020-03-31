
#--- CALLLING MODULES

#Adding variable for identify customer resources
variable "CustomerCode" { 
 description = "Enter a unique, *lower-case* two-letter ID to identify customer resource group"
}

#---- PEERING Admin Vnet and Load-balancer Vnet ---#
module "Creates-Peering-Between-Vnet1-and-Vnet2" {
    source                      = "./peering"
    CustomerCode                = "${var.CustomerCode}"
    
  }




