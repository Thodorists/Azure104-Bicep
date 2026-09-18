$ResourceGroupName = "labCli"

$Location = "polandcentral"

$VnetName = "vnet"

$AddressSpace = "10.0.0.0/16"

new-AzVirtualNetwork -Name $VnetName -ResourceGroupName $ResourceGroupName `
-Location $Location -AddressPrefix $AddressSpace

