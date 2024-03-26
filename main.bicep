targetScope = 'subscription'

param location string = 'southcentralus'
param resourcePrefix string = 'aks-dns-ex2'
param zoneName string = 'contoso.com'
param recordName string = 'db'

var aksResourceGroupName = '${resourcePrefix}-rg'
var vnetResourceGroupName = 'vnet-${resourcePrefix}-rg'
var contributorRoleId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b24988ac-6180-42a0-ab88-20f7382dd24c')

resource clusterrg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: aksResourceGroupName
  location: location
}

resource vnetrg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: vnetResourceGroupName
  location: location
}

module aksvnet './aks-vnet.bicep' = {
  name: 'aks-vnet'
  scope: vnetrg
  params: {
    location: location
    subnets: [
      {
        name: 'aks-subnet'
        properties: {
          addressPrefix: '10.0.0.0/16'
        }
      } 
      {
        name: 'subnet2'
        properties: {
          addressPrefix: '10.100.0.0/24'
        }
      }
    ]
    vnetName: 'aks-vnet'
    vvnetPreffix:  [
      '10.0.0.0/8'
    ]
  }
}

module privatednszone './private-dns-zone.bicep' = {
  name: 'private-dns-zone'
  scope: vnetrg
  dependsOn: [
    aksvnet
  ]
  params: {
    privateDnsZoneName: zoneName
    recordName: recordName
    privateDnsZoneLinkName: 'aks-vnet-link'
    aksVnetId: aksvnet.outputs.aksVnetId
  }
}

module akscluster './aks-cluster.bicep' = {
  name: resourcePrefix
  scope: clusterrg
  dependsOn: [ aksvnet, privatednszone ]
  params: {
    location: location
    clusterName: resourcePrefix
    aksSubnetId: aksvnet.outputs.akssubnet
  }
}

module roleAuthorization 'aks-auth.bicep' = {
  name: 'roleAuthorization'
  scope: vnetrg
  dependsOn: [
    akscluster
  ]
  params: {
      principalId: akscluster.outputs.aks_principal_id
      roleDefinition: contributorRoleId
  }
}

module kubernetes './dns-monitor.bicep' = {
  name: 'buildbicep-deploy'
  scope: clusterrg
  dependsOn: [
    akscluster
  ]
  params: {
    kubeConfig: akscluster.outputs.kubeConfig
  }
}

module kubernetes2 './workloads.bicep' = {
  name: 'buildbicep-deploy2'
  scope: clusterrg
  dependsOn: [
    akscluster
  ]
  params: {
    kubeConfig: akscluster.outputs.kubeConfig
  }
}
