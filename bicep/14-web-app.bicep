
resource plan 'Microsoft.Web/serverfarms@2024-11-01' = { 
  name: 'asp-web-dev-plan-01'
  location:'centralus'
  kind: 'linux'
  sku: { 
      name: 'F1'
      capacity:1 
  }
  properties: { 
     name:'asp-web-dev-plan-01'
     reserved:true
  }
}

resource web 'Microsoft.Web/sites@2024-11-01' = { 
    name: 'asp-web-dev-01'
  location:'centralus'
  kind: 'app,linux'
  properties: { 
    name: 'asp-web-dev-01'
    serverFarmId: plan.id
    siteConfig: {
      linuxFxVersion: 'PHP|8.3'
    }
  }
}
