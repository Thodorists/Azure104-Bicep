$ResourceGroupName = "labCli2"
$Location = "polandcentral"
$PublicIpName = "PublicIp"

az network public-ip create --resource-group $ResourceGroupName --location $Location `
--name $PublicIpName --sku Standard --allocation-method static --version IPv4
