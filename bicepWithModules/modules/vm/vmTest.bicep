@description('name of vm')
param baseName string

@description('location of vm')
param location string

@description('size of vm')
param size string //B2ats_v2

@description('username of vm')
param username string = 'azureadmin'

@secure()
@description('password of vm using keyvault ')
param password string

param nicId string
/*@description('nic id for vm ')
param nicid string*/


/*resource nic 'Microsoft.Network/networkInterfaces@2025-09-01' = {
  name: 'nicTest'
  location: location
  properties: {
    ipConfigurations: [{
      name: 'ipconfig1'
      properties: { 
        privateIPAllocationMethod: 'Dynamic'
        subnet: {
          id: subnetId
        }
      }
    }]
  }
}*/


resource vm 'Microsoft.Compute/virtualMachines@2026-04-01' = {
  name: baseName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: size
    }
    osProfile: {
      computerName: baseName
      adminUsername: username
      adminPassword: password
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2025-datacenter'
        version: 'latest'
      }
    osDisk: {
      createOption: 'FromImage'
      managedDisk: {
        storageAccountType: 'Standard_LRS'
        }
      }
    }
    networkProfile: {
      networkInterfaces: [{
        id: nicId
        properties: {primary: true}
      }]
    }
  }
}
