var nsgName           = 'nsg-az104-shared-eus-01'
var any               = '*'

var ruleSshName       = 'in-allow-rdp-admin'
var ruleSshPriority   = 400
var SshPort           = '22'

var svcTagInternet    = 'Internet'
var httpDestIp        = '10.0.0.4'
var httpPort          = '80'
var ruleHttpName      = 'in-allow-http-from-internet-to-10-0-0-4'
var ruleHttpPriority  = 410

resource nsg 'Microsoft.Network/networkSecurityGroups@2024-10-01'={ 
  name: nsgName
  location: resourceGroup().location
  properties: { 
    securityRules: [ 
      {
        name: ruleSshName
        properties: {
          description: 'Allow SSH for admin access.'
          protocol: 'Tcp'
          sourcePortRange: any
          destinationPortRange: SshPort
          sourceAddressPrefix: any
          destinationAddressPrefix: any
          access: 'Allow'
          priority: ruleSshPriority
          direction: 'Inbound'
        }
      }
      {
        name: ruleHttpName
        properties: {
          description: 'Allow HTTP from the Internet service tag to 10.0.0.4.'
          protocol: 'Tcp'
          sourcePortRange: any
          destinationPortRange: httpPort
          sourceAddressPrefix: svcTagInternet
          destinationAddressPrefix: httpDestIp
          access: 'Allow'
          priority: ruleHttpPriority
          direction: 'Inbound'
        }
      }
    ]
  }
}
