resource "azurerm_linux_virtual_machine" "bulbvm" {
    admin_username = "Mike"
    location = azurerm_resource_group.test1.location
    name = "vm-1"
    os_disk {
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
      disk_size_gb = 40
    }
    network_interface_ids = [azurerm_network_interface.nics.id]
    resource_group_name = azurerm_resource_group.test1.name 
    size = "Standard_B1ls"
    admin_ssh_key {
      public_key = file("id_rsa.pub")
      username = "Mike"
    }
    source_image_reference {
      publisher = "Canonical"
      offer ="0001-com-ubuntu-server-jammy"
      sku= "22_04-lts-gen2"
      version= "latest"
    }
  
}
resource "azurerm_network_interface" "nics" {
    ip_configuration {
        name = "bulb-nic-config"
        subnet_id = azurerm_subnet.subneta.id 
        private_ip_address_allocation = "Dynamic"

    }
    location = azurerm_resource_group.test1.location
    name = "bulb-nic"
    resource_group_name = azurerm_resource_group.test1.name
}

output "vm_ip" {
    value = azurerm_linux_virtual_machine.bulbvm.private_ip_address
}