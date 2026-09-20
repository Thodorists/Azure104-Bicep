@description('Virtual machine name')
param vmName string

@description('Admin username for the VM')
param adminUsername string

@secure()
@description('Admin password for the VM')
param adminPassword string

resource nic 'Microsoft.Network/networkInterfaces@2024-10-01' existing = { 
  name: 'nic-web-dev-eus-01'
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
  name: vmName
  location: resourceGroup().location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B1s'
    }

    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
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
