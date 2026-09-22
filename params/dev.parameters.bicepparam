using '../main.bicep'

param location = 'polandcentral'


param vnet = {
  name: 'vnet1'
  addressPrefixes: [
    '10.0.0.0/16'
  ]
  subnets: [
    {
      name: 'subnetWeb'
      prefix: '10.0.0.0/24'
    }
    {
      name: 'subnetDb'
      prefix: '10.0.1.0/24'
    }
  ]
}

param sa = {
  name: '0storageaccount1'
  location: location
  sku: 'Standard_LRS'
  kind: 'StorageV2'
}


param nsg = {
  name: 'web-nsg'
  location: location
  securityRules: [
    {
      name: 'allow-rdp-admin'
      properties: {
        priority: 100
        protocol: 'Tcp'
        access: 'Allow'
        direction: 'Inbound'
        sourceAddressPrefix: '*'
        sourcePortRange: '*'
        destinationAddressPrefix: '*'
        destinationPortRange: '3339'
      }
    }
    {
      name: 'allow-ssh'
      properties: {
        priority: 400
        protocol: 'Tcp'
        access: 'Allow'
        direction: 'Inbound'
        destinationPortRange: '22'
        sourceAddressPrefix: 'Internet'
        sourcePortRange: '*'
        destinationAddressPrefix: '10.0.1.4'
      }
    }
  ]
}
