
var tags = {
  Description: 'MLOPS Demo'
}

param location string = 'westeurope'
param projectName string = 'mlops'
param environment string = 'dev'
param adminUserIds array = []
param computeName string = 'cpu-cluster'
var postFix = uniqueString(subscription().subscriptionId, projectName, environment)


/**************************/
/*     RESOURCES    */
/**************************/

var storageAccountName= 'st${projectName}${postFix}'
var keyVaultName = 'kv-${projectName}-${postFix}'
var appInsightsName = 'ai-${projectName}-${postFix}'
var machineLearningWorkspaceName = 'mlw-${projectName}-${postFix}'
var containerRegistryName = 'cr${projectName}${postFix}'


module st 'modules/storageaccount.bicep' = {
  name: 'storageAccountDeploy'
  params:{
    name: storageAccountName
    location: location
    sku: 'Standard_LRS'
    kind: 'StorageV2'
    tags: tags
    containers: [
      'data'
    ]
  }
}

module kv 'modules/keyvault.bicep' = {
  name:'keyVaultDeploy'
  params: {
    location: location
    name: keyVaultName
    tags: tags
    adminUserIds: adminUserIds
  }
}


module ai_web 'modules/applicationinsights.bicep' = {
  name: 'applicationInsightsDeploy'
  params:{
    location: location
    name: appInsightsName
    type: 'web'
    tags: tags
  }
}

module cr 'modules/containerregistry.bicep' = {
  name: 'containerRegistryDeploy'
  params:{
    location: location
    name: containerRegistryName
    tags: tags
  }
}

module mlw 'modules/machinelearningworkspace.bicep' = {
  name: 'machinelearningworkspaceDeploy'
  params:{
    location: location
    name: machineLearningWorkspaceName
    tags: tags
    applicationInsightsId: ai_web.outputs.id
    containerRegistryId: cr.outputs.id
    keyvaultId: kv.outputs.id
    storageAccountId: st.outputs.id
    computeName: computeName
  }
}
