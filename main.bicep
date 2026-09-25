param location string
param vnet object
param sa object
param nsg object
param vm object
@secure()
param vmPassword string
param deployBastion bool = false
param deployLoadBalancer bool = false
param ilb object

//to vnet object einai to object tou param file pou exeis dilwsei aftoto main arxeio 
//vnet.name einai to name tou object tou param poy to dineis sto vnet.bicep resource
module devvnet 'bicepWithModules/modules/network/vnet.bicep' = {
  name: 'dev-network'
  params: {
    name: vnet.name
    location: location
    addressPrefixes: vnet.addressPrefixes
    subnets: vnet.subnets
    nsgName: nsg.name
  }
}

module storage 'bicepWithModules/modules/storage/storage.bicep' = {
  name: 'dev_storage'
  params: {
    name: sa.name
    location: sa.location
    sku: sa.sku
    kind: sa.kind
  }
}

module Nsg 'bicepWithModules/modules/nsg/nsg.bicep' = {
  name: 'dev_nsg'
  params: {
    name: nsg.name
    location: nsg.location
    securityRules: nsg.securityRules
  }
}

module Vm 'bicepWithModules/modules/vm/vm.bicep' = {
  name: 'dev_vms'
  params: {
    baseName: vm.baseName
    location: location
    size: vm.size
    username: vm.username
    password: vmPassword
    count: vm.count
    subnetId: devvnet.outputs.subnetWebId
    lbBackendPoolId: ilbr.outputs.backendPoolId
  }
}

module Bastion 'bicepWithModules/modules/bastion/bastion.bicep' = if (deployBastion) {
  name: 'dev-bastion'
  params: {
    location: location
    bastionSubnetId: devvnet.outputs.bastionSubnetId
  }
}

module ilbr './bicepWithModules/modules/network/internalLb.bicep' = if (deployLoadBalancer) { 
   name: 'ilb'
   params: { 
      location:location
      lbName: ilb.name
      subnetId:devvnet.outputs.subnetWebId
   }
}
