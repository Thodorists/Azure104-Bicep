#orizis to iparxon vnet kai meta kanis attach to subnet 

$ResourceGroupName = "labCli"
$VnetName = "vnet"
$SubnetName = "subnet"
$SubnetAddressPrefix = "10.0.0.0/24"


$Vnet = Get-AzVirtualNetwork -ResourceGroupName $ResourceGroupName -Name $VnetName

Add-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork $Vnet -AddressPrefix $SubnetAddressPrefix

#gia update tou vnet sto azure
$Vnet | Set-AzVirtualNetwork 