resource "azurerm_managed_disk" "test" {
name = "datadisk_existing"
location="${azurerm_resource_group.res_group.location}"
resource_group_name = "${azurerm_resource_group.res_group.name}"
storage_account_type = "Standard_LRS"
create_option = "Empty"
disk_size_gb = "1023"
}

resource "azurerm_virtual_machine" "test" {
name = "myvm"
location="${azurerm_resource_group.res_group.location}"
resource_group_name = "${azurerm_resource_group.res_group.name}"
network_interface_ids = ["${azurerm_network_interface.my_int.id}"]
vm_size = "Standard_DS1_v2"
delete_os_disk_on_termination = "true"
delete_data_disks_on_termination = "true"

storage_image_reference {
publisher = "${var.vm_image_publisher}"
offer = "${var.vm_image_offer}"
sku = "${var.vm_image_sku}"
version = "${var.vm_image_version}"
}

storage_os_disk {
name = "datadisk_new_2018_01"
caching = "ReadWrite"
create_option = "FromImage"
managed_disk_type="Standard_LRS"
}

# Adding additional disk 1

storage_data_disk {
name = "datadisk_new"
managed_disk_type = "Standard_LRS"
create_option = "Empty"
lun = 0
disk_size_gb = "1023"
}

#Additional disk 2

storage_data_disk {
name = "${azurerm_managed_disk.test.name}"
managed_disk_id = "${azurerm_managed_disk.test.id}"
create_option = "Attach"
lun = 1
disk_size_gb = "${azurerm_managed_disk.test.disk_size_gb}"
}

#define credentials
os_profile {
computer_name = "SERVER2016"
admin_username = "${var.VM_ADMIN}"
admin_password = "${var.VM_PASSWORD}"
}

os_profile_windows_config {
provision_vm_agent = "true"
enable_automatic_upgrades = "true"
winrm {
protocol = "http"
certificate_url =""
}
}

}

#get public IP
data "azurerm_public_ip" "test" {
name = "${azurerm_public_ip.datasourceip.name}"
resource_group_name = "${azurerm_resource_group.res_group.name}"
depends_on = [azurerm_virtual_machine.test]
}

output "ip_address" {
value = "${data.azurerm_public_ip.test.ip_address}"
}