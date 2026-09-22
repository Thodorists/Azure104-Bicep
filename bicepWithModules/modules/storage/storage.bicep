@description('name of storage')
param name string

@description('location of storage')
param location string

@description('sku of storage')
param sku string

@description('kind of storage')
param kind string


resource sa 'Microsoft.Storage/storageAccounts@2026-04-01' = {
  name: name
  location: location
  sku: {
    name: sku
  }
  kind: kind
}
