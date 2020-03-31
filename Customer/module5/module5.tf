#--- CALLLING MODULES

# Define variable
variable "CustomerCode" { 
  description = "Enter a unique, *lower-case*letter ID to identify customer resource group."
}


  #---- CaLLING Database ---#
     module "NE-HA-S12-CSM-Test-101" {
    source                      = "./CSM-database/NE-HA-S12-CSM-Test-101"
    CustomerCode                = "${var.CustomerCode}"

  }

   module "NE-HA-S12-CSM-Test-102" {
    source                      = "./CSM-database/NE-HA-S12-CSM-Test-102"
    CustomerCode                = "${var.CustomerCode}"

  }
   module "NE-HA-S12-CSM-Test-103" {
    source                      = "./CSM-database/NE-HA-S12-CSM-Test-103"
    CustomerCode                = "${var.CustomerCode}"

  }
   module "NE-HA-S12-CSM-Test-104" {
    source                      = "./CSM-database/NE-HA-S12-CSM-Test-104"
    CustomerCode                = "${var.CustomerCode}"

  }
   module "NE-HA-S12-CSM-Test-105" {
    source                      = "./CSM-database/NE-HA-S12-CSM-Test-105"
    CustomerCode                = "${var.CustomerCode}"

  }
