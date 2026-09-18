$ResourceGroupName = "labCli"
$StorageAccountName = "storageaacount"
$Location = "polandcentral"
$Kind = "StorageV2"
$Sku = "Standard_LRS"

New-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName `
-Location $Location -Kind $Kind -SkuName $Sku