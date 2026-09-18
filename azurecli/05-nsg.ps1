$ResourceGroupName = "labCli2"
$Location = "polandcentral"
$SubnetName = "subnet"
$VnetName = "vnet"
$NsgName = "nsg"

az network nsg create --name $NsgName --resource-group $ResourceGroupName --location $Location `


az network nsg rule create --name "in-allow-ssh-admin" --resource-group $ResourceGroupName `
--nsg-name $NsgName --access allow --priority 400 --direction Inbound --protocol Tcp `
--source-address-prefixes Internet --source-port-range "*" `
--destination-address-prefixes "10.0.0.4" --destination-port-ranges 22

az network nsg rule create --name "in-allow-http-from-internet-to-10.0.0.4" --resource-group $ResourceGroupName `
--nsg-name $NsgName --access allow --priority 410 --direction Inbound --protocol Tcp `
--source-address-prefixes Internet --source-port-range "*" `
--destination-address-prefixes "10.0.0.4" --destination-port-ranges 80

#attach nsg to vnet subnet
<# az network vnet subnet update

Δηλαδή λέμε στο Azure:

«Κάνε update σε ένα subnet μέσα σε ένα συγκεκριμένο VNet.»#>
az network vnet subnet update --resource-group $ResourceGroupName `
--vnet-name $VnetName  --name $SubnetName --network-security-group $NsgName