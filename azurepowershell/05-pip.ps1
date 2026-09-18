$ResourceGroupName = "labCli"
$Location = "polandcentral"
$PublicIpName = "PublicIp"
$NicName = "nic"
$IpConfigName = "ipconfig"

$Pip = New-AzPublicIpAddress -Name $PublicIpName -ResourceGroupName $ResourceGroupName -Location $Location `
-Sku Standard -AllocationMethod Static

#gia na paroume to nic pou prepei na ginei attach i ip poy tha exei kai to vm to nic

$Nic = Get-AzNetworkInterface -Name $NicName -ResourceGroupName $ResourceGroupName 

Set-AzNetworkInterfaceIpConfig -Name $IpConfigName -NetworkInterface $Nic -PublicIpAddress $Pip | Out-Null

#gia update sto azure 

$Nic | Set-AzNetworkInterface 