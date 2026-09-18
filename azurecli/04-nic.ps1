$ResourceGroupName = "labCli2"
$Location = "polandcentral"
$PublicIpName = "PublicIp"
$NicName = "nic"
$SubnetName = "subnet"
$VnetName = "vnet"

az network nic create --name $NicName --resource-group $ResourceGroupName --location $Location `
--vnet-name $VnetName --subnet $SubnetName --public-ip-address $PublicIpName