targetScope = 'resourceGroup'

var name = 'vnet1'
var location = 'polandcentral'
var subnameWeb = 'subweb'
var subnameDb = 'dbsub'
var nsgName = 'nsg'

resource nsg 'Microsoft.Network/networkSecurityGroups@2025-09-01' existing = {
  name: nsgName
}

resource vnet 'Microsoft.Network/virtualNetworks@2025-09-01' = {
  name: name
  location: location
  properties: {
    addressSpace: {addressPrefixes:['10.0.0.0/16']}
    subnets: [
      {
        name: subnameDb
        properties: {addressPrefix: '10.0.0.0/24'}
      }
      {
        name: subnameWeb
        properties: {addressPrefix: '10.0.1.0/24', networkSecurityGroup: {id: nsg.id }}
      }
    ]
  }
}
