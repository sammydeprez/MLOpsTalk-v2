param location string
param name string
param kind string
param sku string
param tags object
param containers array = []

resource st 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: name
  location: location
  tags: tags
  sku: {
    name: sku
  }
  kind: kind
  properties:{
    accessTier: 'Hot'
    supportsHttpsTrafficOnly: true
  }
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2022-09-01' = {
  name: 'default'
  parent: st
}


resource symbolicname 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = [for container in containers:{
  name: container
  parent: blobService
}]

output id string = st.id
