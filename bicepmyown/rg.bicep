targetScope = 'subscription'

var resourceGroupName = 'resourceGroupPolandCentral'
var location = 'polandcentral'

resource rg 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: resourceGroupName
  location: location
}
