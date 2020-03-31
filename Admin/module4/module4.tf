
#--- CALLLING MODULES


#---- Calling virtual machines ---#
   module "NE-Bast-Test-01" {
    source                      = "./admin-Environment/NE-Bast-Test-01"

  }

  module "NE-Nes-Test-02" {
    source                      = "./admin-Environment/NE-Nes-Test-02"

  }

module "NE-AD-Test-03" {
    source                      = "./admin-Environment/NE-AD-Test-03"

  }

  module "NE-MON-Test-04" {
    source                      = "./admin-Environment/NE-MON-Test-04"

  }

  module "NE-SQLMgn-Test-05" {
    source                      = "./admin-Environment/NE-SQLMgn-Test-05"

  }

    module "NE-WSUS-Test-05" {
    source                      = "./admin-Environment/NE-WSUS-Test-05"

  }






