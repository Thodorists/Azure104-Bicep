$ResourceGroupName = "labCli"
$Location = "polandcentral"
$NicName = "nic"
$VnetName = "vnet"
$SubnetName = "subnet"
$IpConfigName = "ipconfig"

#gia na paroume to subnet 

$Vnet = Get-AzVirtualNetwork -ResourceGroupName $ResourceGroupName -Name $VnetName
$Subnet = Get-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork $Vnet

New-AzNetworkInterface -Name $NicName `
-ResourceGroupName $ResourceGroupName `
-Location $Location `
-Subnet $Subnet `
-IpConfigurationName $IpConfigName