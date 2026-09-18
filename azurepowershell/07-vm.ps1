$ResourceGroupName = "labCli"
$Location = "polandcentral"
$VmSize = "Standard_B2ats_v2"
$VmName = "vm"
$NicName = "nic"

$VmConfig = New-AzVMConfig -VMName $VmName -VMSize $VmSize

$Credential = Get-Credential 

$VmConfig = Set-AzVMOperatingSystem -VM $VmConfig -Linux -ComputerName $VmName -Credential $Credential

$VmConfig = Set-AzVMSourceImage -VM $VmConfig -PublisherName "Canonical" -Offer "ubuntu-24_04-lts" `
-Skus "Server" -Version "latest"

$Nic = Get-AzNetworkInterface -Name $NicName -ResourceGroupName $ResourceGroupName 

$VmConfig = Add-AzVMNetworkInterface -VM $VmConfig -Id $Nic.Id 

New-AzVM -ResourceGroupName $ResourceGroupName -Location $Location -VM $VmConfig