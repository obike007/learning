resource "azurerm_resource_group" "test1" {
  name     = "thebulbrg"
  location = "West Europe"
}


resource "azurerm_virtual_network" "testvnet" {
    name = "bulb_vnet"
    resource_group_name = azurerm_resource_group.test1.name
    address_space = ["10.0.0.0/16"]
    location = azurerm_resource_group.test1.location
}

resource "azurerm_subnet" "subneta"{
    name = "subnet-A"
    resource_group_name = azurerm_resource_group.test1.name
    virtual_network_name = azurerm_virtual_network.testvnet.name
    address_prefixes = ["10.0.0.0/28"]

}
resource "azurerm_network_security_group" "nsg1"{
    name = "NSG-1"
    resource_group_name = azurerm_resource_group.test1.name
    location = azurerm_resource_group.test1.location
    security_rule{
        name = "Allow_80"
        protocol = "Tcp"
        source_port_range = 80
        access = "Allow"
        direction = "Inbound"
        priority = 101
        destination_port_range = 80
        source_address_prefix = "*"
        destination_address_prefix = "*"

    }
    tags ={
        team = "devops"
    }
} 

resource "azurerm_subnet_network_security_group_association" "nsg1sr" {
    network_security_group_id = azurerm_network_security_group.nsg1.id 
    subnet_id = azurerm_subnet.subneta.id
}