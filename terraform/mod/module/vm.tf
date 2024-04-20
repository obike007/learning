resource "azurerm_linux_virtual_machine" "bulbvm" {
    count = var.vmcount
    admin_username = var.admin_name
    location = azurerm_resource_group.test1.location
    name = "vm-${count.index}"
    os_disk {
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
      disk_size_gb = 40
    }
    network_interface_ids = [element(azurerm_network_interface.nics[*].id, count.index)]
    resource_group_name = azurerm_resource_group.test1.name 
    size = "Standard_B1ls"
    admin_ssh_key {
      public_key = file("id_rsa.pub")
      username = var.admin_name
    }
    source_image_reference {
      publisher = "Canonical"
      offer ="0001-com-ubuntu-server-jammy"
      sku= "22_04-lts-gen2"
      version= "latest"
    }
    provisioner "file" {
      source      = "index.html"
      destination = "/tmp/index.html"
      connection {
        type     = "ssh"
        user     = var.admin_name
        private_key = file("id_rsa")
        host     = self.public_ip_address
        }
    }
    provisioner "remote-exec" {
      inline = [
        "sudo apt-get update",
        "sudo apt-get install nginx -y",
        "sudo systemctl start nginx.service",
        "sudo cp /tmp/index.html /var/www/html/index.html",
        ]
      connection {
        type     = "ssh"
        user     = var.admin_name
        private_key = file("id_rsa")
        host     = self.public_ip_address
        }
    }
  
}
resource "azurerm_network_interface" "nics" {
    count = var.vmcount
    ip_configuration {
        name = "bulb-nic-config"
        subnet_id = azurerm_subnet.subneta.id 
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = azurerm_public_ip.publicips[count.index].id

    }
    location = azurerm_resource_group.test1.location
    name = "bulb-nic-${count.index}"
    resource_group_name = azurerm_resource_group.test1.name
}

resource "azurerm_public_ip" "publicips" {
  count = var.vmcount
  name                = "public-ip-${count.index}"
  resource_group_name = azurerm_resource_group.test1.name
  location            = azurerm_resource_group.test1.location
  allocation_method   = "Dynamic"

}




output "vm_ip" {
    value = azurerm_linux_virtual_machine.bulbvm[*].public_ip_address
}