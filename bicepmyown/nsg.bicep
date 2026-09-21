var nsgName = 'nsg'
var nicname = 'nic'
var vnetName = 'vnet1'
var location = 'polandcentral'
var subnameWeb = 'subweb'

resource vnet 'Microsoft.Network/virtualNetworks@2025-09-01' existing = {
  name: vnetName

}


resource nsg 'Microsoft.Network/networkSecurityGroups@2025-09-01' = {
  name: nsgName
  location: location
  properties: {
    securityRules: [
      {
        name: 'allow-ssh'
        properties: {
          direction: 'Inbound'
          protocol: 'Tcp'
          priority: 400
          access: 'Allow'
          destinationPortRange: '22'
          sourceAddressPrefix: 'Internet'
          sourcePortRange: '*'
          destinationAddressPrefix: '10.0.1.4'
        }
      }
      {
        name: 'allow-http'
        properties: {
          direction: 'Inbound'
          protocol: 'Tcp'
          priority: 410
          access: 'Allow'
          destinationPortRange: '80'
          sourcePortRange: '*'
          sourceAddressPrefix: 'Internet'
          destinationAddressPrefix: '10.0.1.4'
        }
      }
    ]
  }
}

resource publicIp 'Microsoft.Network/publicIPAddresses@2025-09-01' = {
  name: 'pip1'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2025-09-01' = {
  name: nicname
  location: location
  properties: {
    nicType: 'Standard'
    networkSecurityGroup: {
      id: nsg.id
    }
    ipConfigurations: [
      {
        name: 'ipconfig'
        properties: {
          publicIPAddress: {
            id: publicIp.id
          }
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets',vnet.name, subnameWeb)
          }
        }
      }
    ]
  }
}


