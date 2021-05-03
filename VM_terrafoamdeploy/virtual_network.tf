#Create Public IP

resource "azurerm_public_ip" "datasourceip" {
name = "testPublicIp"
location="${azurerm_resource_group.res_group.location}"
resource_group_name = "${azurerm_resource_group.res_group.name}"
allocation_method= "Dynamic"
}

 

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "my_virt_net" {
name = "production-network"
address_space = ["10.0.0.0/16"]
location = "${azurerm_resource_group.res_group.location}"
resource_group_name = "${azurerm_resource_group.res_group.name}"

}

#create subnets
resource "azurerm_subnet" "test1" {
name = "subnet1"
resource_group_name = "${azurerm_resource_group.res_group.name}"
virtual_network_name="${azurerm_virtual_network.my_virt_net.name}"
address_prefix = "10.0.1.0/24"
}

resource "azurerm_subnet" "test2" {
name = "subnet2"
resource_group_name = "${azurerm_resource_group.res_group.name}"
virtual_network_name="${azurerm_virtual_network.my_virt_net.name}"
address_prefix = "10.0.2.0/24"
}

resource "azurerm_subnet" "test3" {
name = "subnet3"
resource_group_name = "${azurerm_resource_group.res_group.name}"
virtual_network_name="${azurerm_virtual_network.my_virt_net.name}"
address_prefix = "10.0.3.0/24"
}

 

#Create network interface

resource "azurerm_network_interface" "my_int" {
name = "myWindowsServer_NIC"
location = "${azurerm_resource_group.res_group.location}"
resource_group_name = "${azurerm_resource_group.res_group.name}"
#network_security_group_id = "${var.vm_security_group_id}"
ip_configuration {
name = "Server2016"
subnet_id = "${azurerm_subnet.test1.id}"
private_ip_address_allocation = "dynamic"
public_ip_address_id = "${azurerm_public_ip.datasourceip.id}"
}
}