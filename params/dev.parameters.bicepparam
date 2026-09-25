using '../main.bicep'

param location = 'polandcentral'
param deployBastion = false
param deployLoadBalancer = false

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
      {
      name: 'AzureBastionSubnet'
      prefix: '10.0.3.0/26'
    }
  ]
}

param sa = {
  name: '0storageaccount1'
  location: location
  sku: 'Standard_LRS'
  kind: 'StorageV2'
}


param nsg = {
  name: 'web-nsg'
  location: location
  securityRules: [
    {
      name: 'allow-rdp-admin'
      properties: {
        priority: 100
        protocol: 'Tcp'
        access: 'Allow'
        direction: 'Inbound'
        sourceAddressPrefix: '*'
        sourcePortRange: '*'
        destinationAddressPrefixes: [
          '10.0.0.4'
          '10.0.0.5'
        ]
        destinationPortRange: '3389'
      }
    }
    {
      name: 'allow-ssh'
      properties: {
        priority: 400
        protocol: 'Tcp'
        access: 'Allow'
        direction: 'Inbound'
        destinationPortRange: '22'
        sourceAddressPrefix: 'Internet'
        sourcePortRange: '*'
        destinationAddressPrefix: '10.0.1.4'
      }
    }
    {
      name: 'allow-http'
      properties: {
        priority: 110
        protocol: 'Tcp'
        access: 'Allow'
        direction: 'Inbound'
        destinationPortRange: '443'
        sourceAddressPrefix: 'Internet'
        sourcePortRange: '*'
        destinationAddressPrefix: '10.0.3.0/26'
      }
    }
  ]
}


param vm = {
  baseName: 'web'
  location: location
  size: 'Standard_B2ats_v2'
  username: 'azureadmin'
  count: 2
}

param vmPassword = az.getSecret(
  '484a8583-4b41-4857-9f62-7e5676283498',
  'rg-poland-central',
  'project-az104',
  'WindowsMachine'
)

param ilb = {
  name: 'internal-lb-az104'
  feName: 'fe-ilb-01'
  beName: 'be-ilb-01'
  probeName: 'hp-http-80'
  probePath: '/'
  ruleName: 'lbr-http-80'
}
