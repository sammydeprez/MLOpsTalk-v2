param location string
param name string
param tags object
param storageAccountId string
param keyvaultId string
param containerRegistryId string
param applicationInsightsId string

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
