$ResourceGroupName = "labCli2"
$Location = "polandcentral"
$VmSize = "Standard_B2ats_v2"
$VmName = "vm"
$NicName = "nic"
$StorageAccountName = "storageaacountcli"
$AvSetName = "as"
$DataDiskName = "disk"

az vm availability-set create `
--resource-group $ResourceGroupName `
--location $Location `
--name $AvSetName `
--platform-fault-domain-count 2

az disk create `
--resource-group $ResourceGroupName `
--location $Location `
--name $DataDiskName `
--size-gb 16 `
--sku StandardSSD_LRS 

az vm create `
--resource-group $ResourceGroupName `
--location $Location `
--name $VmName `
--nics $NicName `
--size $VmSize `
--availability-set $AvSetName `
--admin-username linuxadmin `
--authentication-type ssh `
--generate-ssh-keys `
--image "Canonical:ubuntu-24_04-lts:server:latest"

az vm disk attach `
--resource-group $ResourceGroupName `
--vm-name $VmName `
--name $DataDiskName `
--lun 0 `
--caching ReadWrite


az vm boot-diagnostics enable ` <#an thes mono#>`
--resource-group $ResourceGroupName `
--name $VmName `
--storage $StorageAccountName
