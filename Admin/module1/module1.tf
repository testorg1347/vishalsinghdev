
#--- CALLLING MODULES

#Adding variable for identify customer resources
variable "CustomerCode" { 
 description = "Enter a unique, *lower-case* two-letter ID to identify customer resources"
}

#---- 1st VIRTUAL NETWORK ---#
module "creates-vnet1" {
    source                      = "./Vnet/createsvnet1"
    #CustomerCode                = "${var.CustomerCode}"
    
  }


