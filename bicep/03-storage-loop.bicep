resource sa 'Microsoft.Storage/storageAccounts@2025-01-01' = [for i in range(0,3):{
  name : '${i}stcloudhubdev2000'
  location: 'eastus'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}]
