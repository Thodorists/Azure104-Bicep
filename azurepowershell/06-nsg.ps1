$ResourceGroupName = "labCli"
$Location = "polandcentral"
$NsgName = "nsg"
$VnetName = "vnet"
$SubnetName = "subnet"

$AllowHttp = New-AzNetworkSecurityRuleConfig -Name "in-allow-http-from-internet-to-10.0.0.4" `
-Access Allow -Protocol Tcp -Direction Inbound -Priority 410 `
-SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix '10.0.0.4' `
-DestinationPortRange 80

$AllowSsh = New-AzNetworkSecurityRuleConfig -Name "in-allow-ssh-admin" `
-Access Allow -Protocol Tcp -Direction Inbound -Priority 400 `
-SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix '10.0.0.4' `
-DestinationPortRange 22

$Nsg = New-AzNetworkSecurityGroup -Name $NsgName -ResourceGroupName $ResourceGroupName -Location $Location `
-SecurityRules $AllowHttp, $AllowSsh

#pernis to vnet kai kaneis setsubnet sto vnet me to addressprefix kai me to nsg 
$Vnet = Get-AzVirtualNetwork -ResourceGroupName $ResourceGroupName -Name $VnetName

Set-AzVirtualNetworkSubnetConfig -VirtualNetwork $Vnet -Name $SubnetName `
-AddressPrefix "10.0.0.0/24" -NetworkSecurityGroup $Nsg

$Vnet | Set-AzVirtualNetwork
