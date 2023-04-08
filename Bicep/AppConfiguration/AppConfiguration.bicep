
param configStoreName string
param location string = resourceGroup().location

param keyValueNames array = [
  'FontColor$Development'
  'FontColor$Production'
  'Sentinel'
]

param keyValueValues array = [
  'White'
  'Purple'
  '011320230556'
]

resource configStore 'Microsoft.AppConfiguration/configurationStores@2022-05-01' = {
  location: location
  properties: {
    encryption: {
    }
    disableLocalAuth: false
    softDeleteRetentionInDays: 7
    enablePurgeProtection: false
  }
  sku: {
    name: 'standard'
  }
  name: configStoreName
  tags: {
  }
}

param contentType string = 'string'

resource configStoreValues 'Microsoft.AppConfiguration/configurationStores/keyValues@2021-10-01-preview' = [for (item, i) in keyValueNames: {
  parent: configStore
  name: item
  properties: {
    value: keyValueValues[i]
    contentType: contentType
  }
}]
