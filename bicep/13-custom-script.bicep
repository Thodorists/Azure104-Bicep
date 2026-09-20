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

resource dataDisk 'Microsoft.Compute/disks@2025-01-02' = { 
   name: 'disk-web-data-dev-eus-01'
  location: resourceGroup().location
  sku : { 
    name: 'Standard_LRS'
  }
  properties: { 
    creationData: {createOption:'Empty'}
    diskSizeGB: 16
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

      dataDisks:[ {
        createOption: 'Attach'
        lun: 0
        managedDisk: { 
          id: dataDisk.id
        }
      }]
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

resource cse 'Microsoft.Compute/virtualMachines/extensions@2021-04-01' = {
  name: 'ext-nginx-setup'            
  parent: vm                          
  location: resourceGroup().location
  properties: {
    publisher: 'Microsoft.Azure.Extensions'
    type: 'CustomScript'
    typeHandlerVersion: '2.1'
    autoUpgradeMinorVersion: true
  
    settings: {
      fileUris: [
        'https://stcloudhubdev2000.blob.core.windows.net/scripts/setup-nginx.sh?sp=r&st=2025-10-07T12:56:23Z&se=2025-10-07T21:11:23Z&spr=https&sv=2024-11-04&sr=b&sig=wo8Ne%2BcjxCw1URCROg8%2BvF0pz%2FcvNgMh2yo9cyMlL1s%3D'
      ]
    }
  
    protectedSettings: {
      commandToExecute: 'bash setup-nginx.sh'
    }
  }
}
