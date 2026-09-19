$ResourceGroupName = "labCli2"
$StorageAccountName = "storageaacountcli"
$Location = "polandcentral"
$Kind = "StorageV2"
$Sku = "Standard_LRS"

az storage account create --resource-group $ResourceGroupName --name $StorageAccountName `
--location $Location --kind $Kind --sku $Sku