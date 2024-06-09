provider "azurerm" {
 features {}
}
 resource "azurerm_resource_group" "rg" {
  name = "newterr"
  location = "EastUS"
}
 resource "azurerm_virtual_network" "vnet" {
  name = "tertest"
  location = "EastUS"
  address_space = ["10.12.0.0/16"]
  resource_group_name = azurerm_resource_group.rg.name
}
 resource "azurerm_subnet" "snet" {
  name = "snettertest"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = ["10.12.1.0/24"]
}   
 resource "azurerm_network_interface" "nic" {
  name                = "NIC_Test"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.rg.name
  
  ip_configuration {
   name = "tertestcon"
   subnet_id = azurerm_subnet.snet.id
   private_ip_address_allocation = "Dynamic"
 }
} 
resource "azurerm_virtual_machine" "TRVMSet" {
  name = "VMtertest"
  resource_group_name = azurerm_resource_group.rg.name
  location = "EastUS"
  vm_size = "Standard_B1s"
  network_interface_ids = [azurerm_network_interface.nic.id]
  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
   name = "tervmdisk"
   create_option = "FromImage"
   caching = "ReadWrite"
   os_type = "Linux"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}
/*  data "azurerm_virtual_machine" "impvs" {
   resource_group_name = azurerm_resource_group.rg.name
   name = "TestTer"
} */
/*  output "impvs" {
   value = data.azurerm_virtual_machine.impvs
} */
