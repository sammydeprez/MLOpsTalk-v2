param keyvaultName string
param objectId string

resource keyvault_access 'Microsoft.KeyVault/vaults/accessPolicies@2022-07-01' = {
  name: '${keyvaultName}/add'
  properties: {
    accessPolicies: [
      {
        objectId: objectId
        tenantId: subscription().tenantId
        permissions:{
          secrets:[
            'get'
            'list'
            'set'
          ]
        }
      }
    ]
  }
}
