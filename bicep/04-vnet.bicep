resource vnet 'Microsoft.Network/virtualNetworks@2024-10-01' ={
  name: 'vnet-dev-eus-01'
  location: 'eastus'
  properties: {
    addressSpace: {addressPrefixes:['10.0.0.0/16']}
    subnets:[
      {
        name:'snet-dev-eus-web-01'
        properties:{addressPrefix:'10.0.0.0/24'}
      }
      {
        name:'snet-dev-eus-db-01'
        properties:{addressPrefix:'10.0.1.0/24'}
      }
    ]
  }
}
