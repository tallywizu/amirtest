resource "azurerm_storage_account" "storage_acc" {
name = "mystorageaccount201801"
resource_group_name = "${azurerm_resource_group.res_group.name}"
location = "${azurerm_resource_group.res_group.location}"
account_tier = "Standard"
account_replication_type = "LRS"

}