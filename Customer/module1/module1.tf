

#Adding variable for identify customer resources
variable "CustomerCode" { 
 description = "Enter a unique, *lower-case* two-letter ID to identify customer resources"
}






#---- 2nd VIRTUAL NETWORK ---#

  module "creates-vnet2" {
    source                      = "./Vnet/createvnet2"
    CustomerCode                = "${var.CustomerCode}"
    
  }