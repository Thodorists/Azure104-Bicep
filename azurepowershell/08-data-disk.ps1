$ResourceGroupName = "labCli"
$VmName = "vm"
$DiskName = "disk"

$Vm = Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VmName 

$Vm = Add-AzVMDataDisk -VM $Vm -name $DiskName -DiskSizeInGB 16 -Lun 0 <#logical unit number#> `
 -CreateOption Empty <#create empty disk#> -StorageAccountType StandardSSD_LRS -Caching ReadWrite



Update-AzVM -ResourceGroupName $ResourceGroupName -VM $Vm




