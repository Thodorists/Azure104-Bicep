resource vnet 'Microsoft.Network/virtualNetworks@2024-07-01' existing = {
  name: 'vnet-dev-eus-01'
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' existing = {
  name: 'snet-dev-eus-web-01'
  parent: vnet
}


resource pip 'Microsoft.Network/publicIPAddresses@2024-10-01' existing = { 
    name: 'pip-web-dev-eus-01'
}

resource nic 'Microsoft.Network/networkInterfaces@2024-10-01' = { 
    name:'nic-web-dev-eus-01'
    location: resourceGroup().location
    properties: { 
       ipConfigurations:[
        {
          name:'ipconfig-web-01'
          properties: { 
              privateIPAllocationMethod: 'Dynamic'
              subnet: { 
                 id: subnet.id
              }
              publicIPAddress: { 
                id: pip.id
              }
          }
        }
       ]
    }
}
