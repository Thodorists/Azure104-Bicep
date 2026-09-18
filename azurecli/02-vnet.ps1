$ResourceGroupName = "labCli2"
$Location = "polandcentral"
$VnetName = "vnet"
$AddressSpace = "10.0.0.0/16"
$SubnetName = "subnet"
$SubnetAddressPrefix = "10.0.0.0/24"

az network vnet create --resource-group $ResourceGroupName --name $VnetName --location $Location `
--address-prefixes $AddressSpace --subnet-name $SubnetName --subnet-prefixes $SubnetAddressPrefix