param location string = 'global'
param dataLocation string = 'Asia Pacific'
param acsName string = 'acs-yggdrasil-main'

resource acsService 'Microsoft.Communication/communicationServices@2023-04-01' = {
  name: acsName
  location: location
  properties: {
    dataLocation: dataLocation
    linkedDomains: []
  }
}

output acsEndpoint string = acsService.properties.hostName
output acsId string = acsService.id
