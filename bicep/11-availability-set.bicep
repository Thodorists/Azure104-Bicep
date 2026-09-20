resource nic 'Microsoft.Network/networkInterfaces@2024-10-01' existing = { 
  name: 'nic-web-dev-eus-01'
}

resource avset 'Microsoft.Compute/availabilitySets@2025-04-01' = { 
 name: 'avset-web-dev-eus-01'
  location: resourceGroup().location
  sku: { 
     name: 'Aligned'
  }
  properties: {
    platformFaultDomainCount:2
    platformUpdateDomainCount: 5
  }
}

resource sa 'Microsoft.Storage/storageAccounts@2025-01-01' = {
  name : 'stcloudhubdev2000'
  location: 'eastus'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

var bootDiagBlobEndpoint = sa.properties.primaryEndpoints.blob

resource vm 'Microsoft.Compute/virtualMachines@2024-11-01' = { 
  name: 'vm-dev-eus-web-01'
  location: resourceGroup().location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B1s'
    }

    availabilitySet: { 
      id: avset.id
    }

    osProfile: {
      computerName: 'vm-dev-eus-web-01'
      adminUsername: 'linuxadmin'
      adminPassword: 'Azure@123'
      linuxConfiguration: {
        disablePasswordAuthentication: false
      }
    }

    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: 'ubuntu-24_04-lts'   
        sku: 'server'
        version: 'latest'
      }

      osDisk: {
        name: 'osdisk-vm-dev-eus-web-01'
        caching: 'ReadWrite'
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
    }

    networkProfile: { 
       networkInterfaces: [ {
        id:nic.id
       }]
    }

    diagnosticsProfile: { 
      bootDiagnostics: {
        enabled:true
        storageUri:bootDiagBlobEndpoint
      }
    }
  }
}
