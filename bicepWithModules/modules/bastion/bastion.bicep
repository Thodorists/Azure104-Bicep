@description('location of bastion')
param location string

@description('subnet of bastion')
param bastionSubnetId string


resource bastionPip 'Microsoft.Network/publicIPAddresses@2024-07-01' = {
  name: 'pip-bastion'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource bastion 'Microsoft.Network/bastionHosts@2024-10-01' = {
  name: 'bastion-az104'
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    ipConfigurations: [
      {
        name: 'bastion-ipconfig'
        properties: {
          publicIPAddress: {
            id: bastionPip.id
          }
          subnet: {
            id: bastionSubnetId
          }
        }
      }
    ]
  }
}
