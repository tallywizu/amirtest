variable "AZURE_SUBSCRIPTION_ID" {}
variable "AZURE_CLIENT_ID" {}
variable "AZURE_CLIENT_SECRET" {}
variable "AZURE_TENANT_ID" {} 

#to get all sizes:https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes-general

variable "vm_size" {
// Get-AzureRmVMSize -Location 'uksouth' | select name, NumberOfCores, MemoryInMB, ResourceDiskSizeInMB | ft
//https://azure.microsoft.com/en-us/documentation/articles/cloud-services-sizes-specs/
//https://azure.microsoft.com/en-gb/documentation/articles/virtual-machines-windows-sizes/
//https://azure.microsoft.com/en-us/pricing/details/virtual-machines/windows/
description = "VM instance size"
default = "Standard_B1ms"
}

variable "vm_image_publisher" {
// Get-AzureRmVMImagePublisher -Location 'uksouth' | Select PublisherName
description = "vm image vendor"
default = "MicrosoftWindowsServer"
}
variable "vm_image_offer" {
//Get-AzureRMVMImageOffer -Location 'uksouth' -Publisher 'MicrosoftWindowsServer' | Select Offer
description = "vm image vendor's VM offering"
default = "WindowsServer"
}

variable "vm_image_sku" {
default = "2016-Datacenter"
}

variable "vm_image_version" {
description = "vm image version"
default = "latest"
}
variable "VM_ADMIN" {
//Disallowed values: "administrator", "admin", "user", "user1", "test", "user2", "test1", "user3", "admin1", "1", "123", "a", "actuser", "adm", "admin2", "aspnet", "backup", "console", "david", "guest", "john", "owner", "root", "server", "sql", "support", "support_388945a0", "sys", "test2", "test3", "user4", "user5".
}

variable "VM_PASSWORD" {
}