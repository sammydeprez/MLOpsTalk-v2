param location string
param name string
param tags object
param storageAccountId string
param keyvaultId string
param containerRegistryId string
param applicationInsightsId string
param computeName string

resource workspace 'Microsoft.MachineLearningServices/workspaces@2022-12-01-preview' = {
  tags: tags
  name: name
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  sku: {
    tier: 'Basic'
    name: 'Basic'
  }
  properties: {
    friendlyName: name
    storageAccount: storageAccountId
    keyVault: keyvaultId
    applicationInsights: applicationInsightsId
    containerRegistry: containerRegistryId
  }
}

resource amlci 'Microsoft.MachineLearningServices/workspaces/computes@2022-12-01-preview' = {
  parent: workspace
  name: computeName
  location: location
  properties: {
    computeType: 'AmlCompute'
    properties: {
      vmSize: 'STANDARD_DS3_V2'
      scaleSettings: {
        minNodeCount: 0
        maxNodeCount: 4
      }
    }
  }
}
