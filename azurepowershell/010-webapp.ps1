$AppServicePlan = "asp"
$ResourceGroupName = "labCli"
$Location = "polandcentral"  
$WebAppName = "webapp"

New-AzAppServicePlan -ResourceGroupName $ResourceGroupName -Location $Location `
-Name $AppServicePlan -Tier 'Free' -Linux #se peritwsi pou thes gia linux gt by default to kanei gia windows

New-AzWebApp -ResourceGroupName $ResourceGroupName -Name $WebAppName -Location $Location `
-AppServicePlan $AppServicePlan

Set-AzResource -ResourceGroupName $ResourceGroupName -ResourceType "Microsoft.Web/Sites/config" `
-ResourceName "$WebAppName/web" -ApiVersion "2022-03-01" -PropertyObject @{linuxFxVersion = "PHP|8.3"} `
-Force




