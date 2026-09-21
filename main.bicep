param location string
param vnet object

module devvnet 'bicepWithModules/modules/network/vnet.bicep' = {
  name: 'dev-network'
  params: {
    name: vnet.name
    location: location
    addressPrefixes: vnet.addressPrefixes
    subnets: vnet.subnets
  }
}
