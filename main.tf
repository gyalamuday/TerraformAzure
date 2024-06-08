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
 /* resource "azurerm_virtual_machine" "TRVMSet" {
  name = "VMtertest"
  resource_group_name = azurerm_resource_group.rg.name
  location = "EastUS"
  vm_size = "Standard_DS1_v2"
  network_interface_ids = [azurerm_network_interface.nic.id]
  storage_os_disk {
   name = "tervmdisk"
   create_option = "FromImage"
   caching = "ReadWrite"
   os_type = "Linux"
 }
} */
/*  data "azurerm_virtual_machine" "impvs" {
   resource_group_name = azurerm_resource_group.rg.name
   name = "TestTer"
} */
/*  output "impvs" {
   value = data.azurerm_virtual_machine.impvs
} */
