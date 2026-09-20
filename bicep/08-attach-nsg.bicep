resource nsg 'Microsoft.Network/networkSecurityGroups@2024-10-01' existing = { 
  name: 'nsg-az104-shared-eus-01'
}

resource vnet 'Microsoft.Network/virtualNetworks@2024-10-01' existing ={ 
   name: 'vnet-dev-eus-01'
}

resource subnetWeb 'Microsoft.Network/virtualNetworks/subnets@2024-10-01' = { 
  name: 'snet-dev-eus-web-01'
  parent: vnet
  properties: {
    addressPrefix: '10.0.0.0/24' 
    networkSecurityGroup: { 
       id: nsg.id
    }
  }
}

resource subnetDb 'Microsoft.Network/virtualNetworks/subnets@2024-10-01' = { 
  name: 'snet-dev-eus-db-01'
  parent: vnet
  properties: {
    addressPrefix: '10.0.1.0/24' 
    networkSecurityGroup: { 
       id: nsg.id
    }
  }
}
