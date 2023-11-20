provider "azurerm" {
  features {}
}

module "rg" {
  source = "../"

  resource_groups = {
    shared-services = {
      resource_group_name = "rg-test-gwc"
      location            = "germanywestcentral"
    }

    datascience = {
      resource_group_name = "rg-dummy-gwc"
      location            = "germanywestcentral"
    }
  }
}
