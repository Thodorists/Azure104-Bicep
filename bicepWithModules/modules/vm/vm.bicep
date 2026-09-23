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

@description('how many vms we create')
param count int

@description('target subnet id ')
param subnetId string

var indexes = [for i in range(1,count):i]
var vmNames = [for i in indexes: 'vm-${baseName}-${i}']
var nicNames = [for i in indexes: 'nic-${baseName}-${i}']

resource nics 'Microsoft.Network/networkInterfaces@2025-09-01' = [for (nicName, i) in nicNames: {
  name: nicName
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
}]

resource vm 'Microsoft.Compute/virtualMachines@2026-04-01' = [ for (vmName, i) in vmNames: {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: size
    }
    osProfile: {
      computerName: vmName
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
        storageAccountType: 'Premium_LRS'
        }
      }
    }
    networkProfile: {
      networkInterfaces: [{
        id: nics[i].id
        properties: {primary: true}
      }]
    }
  }
}]
