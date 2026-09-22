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
