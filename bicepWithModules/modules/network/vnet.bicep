@description('name of vnet')
param name string

@description('location of vnet')
param location string

@description('adress prefixes of vnet')
param addressPrefixes array

@description('subnets in vnet')
param subnets array

@description('name of nsg')
param nsgName string

resource vnet 'Microsoft.Network/virtualNetworks@2025-09-01' = {
  name: name
  location: location
  properties: {
    addressSpace: {addressPrefixes: addressPrefixes}
    subnets: [
      for subnet in subnets : {
        name: subnet.name
        properties: {
          networkSecurityGroup: (subnet.name == 'AzureBastionSubnet') ? null : { id: nsg.id }
          addressPrefix: subnet.prefix
        }
      }
    ]
  }
}
resource nsg 'Microsoft.Network/networkSecurityGroups@2025-09-01' existing = {
  name: nsgName
}

output subnetWebId string = resourceId(
  'Microsoft.Network/virtualNetworks/subnets',
  vnet.name,
  'subnetWeb'
)
output bastionSubnetId string = resourceId(
  'Microsoft.Network/virtualNetworks/subnets',
  vnet.name,
  'AzureBastionSubnet'
)
/*output subnetIds array = [ 
  for s in subnets:{
    name: s.name
    id:resourceId('Microsoft.Network/virtualNetworks/subnets', name, s.name)
  }
]*/
