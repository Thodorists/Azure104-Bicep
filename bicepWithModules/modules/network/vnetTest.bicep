@description('name of vnet')
param name string

@description('location of vnet')
param location string

@description('adress prefixes of vnet')
param addressPrefixes array

@description('subnetPrefix in vnettest subnet')
param subnets array


resource vnetTest 'Microsoft.Network/virtualNetworks@2025-09-01' = {
  name: name
  location: location
  properties: {
    addressSpace: {addressPrefixes: addressPrefixes}
    subnets: [
        { 
          name: name
          properties: {addressPrefix: subnets[0].prefix}
        }
      ]
  }
}
resource nic 'Microsoft.Network/networkInterfaces@2025-09-01' = {
  name: 'nicTest'
  location: location
  properties: {
    ipConfigurations: [{
      name: 'ipconfig1'
      properties: { 
        privateIPAllocationMethod: 'Dynamic'
        subnet: {
          id: vnetTest.properties.subnets[0].id
        }
      }
    }]
  }
}

output subnetTest string = resourceId(
  'Microsoft.Network/virtualNetworks/subnets',
  vnetTest.name,
  'subnetTest'
)
output nicid string = nic.id
