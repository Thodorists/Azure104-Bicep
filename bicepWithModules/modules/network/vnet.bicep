@description('name of vnet')
param name string

@description('location of vnet')
param location string

@description('adress prefixes of vnet')
param addressPrefixes array

@description('subnets in vnet')
param subnets array

resource vnet 'Microsoft.Network/virtualNetworks@2025-09-01' = {
  name: name
  location: location
  properties: {
    addressSpace: {addressPrefixes: addressPrefixes}
    subnets: [
      for subnet in subnets : {
        name: subnet.name
        properties: {
          addressPrefix: subnet.prefix
        }
      }
    ]
  }
}
