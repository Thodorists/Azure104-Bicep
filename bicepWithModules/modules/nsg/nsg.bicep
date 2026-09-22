@description('name of nsg')
param name string

@description('location of nsg')
param location string

@description('location of nsg')
param securityRules array



resource nsg 'Microsoft.Network/networkSecurityGroups@2025-09-01' ={
  name: name
  location: location
  properties:{
    securityRules: securityRules
    }
}


