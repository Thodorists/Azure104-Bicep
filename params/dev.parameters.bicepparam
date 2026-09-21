using '../bicepWithModules/modules/network/vnet.bicep'

param location = 'polandcentral'

param name = 'vnet1'

param addressPrefixes = ['10.0.0.0/16']

param subnets = [
  {
    name: 'subnetWeb'
    prefix: '10.0.0.0/24'
  }
  {
    name: 'subnetDb'
    prefix: '10.0.1.0/24'
  }
]


