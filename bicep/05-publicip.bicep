resource pip 'Microsoft.Network/publicIPAddresses@2024-10-01'={
  name:'pip-web-dev-eus-01'
  location: resourceGroup().location
  sku:{name:'Standard'}
  properties:{publicIPAllocationMethod:'Static'}
}
