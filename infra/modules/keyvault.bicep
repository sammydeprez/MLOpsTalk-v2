param location string
param name string
param tags object
param adminUserIds array

resource kv 'Microsoft.KeyVault/vaults@2022-07-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    tenantId: subscription().tenantId
    sku: {
      family: 'A'
      name: 'standard'
    } 
    accessPolicies: [for objectId in adminUserIds:{
        objectId: objectId
        tenantId: subscription().tenantId
        permissions:{
          secrets:[
            'get'
            'list'
            'set'
          ]
        }
      }]
  }
}

output id string = kv.id
output name string = kv.name
