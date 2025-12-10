targetScope = 'resourceGroup'

param location string = resourceGroup().location
param cosmosName string
param acsName string
param budgetEmails array
param defaultTags object = {}

// Deploy Cosmos DB (The Memory)
module cosmos 'modules/data/cosmos.bicep' = {
  name: 'deploy-cosmos'
  params: {
    location: location
    accountName: cosmosName
    tags: defaultTags
  }
}

// Deploy Monitoring (Logs + App Insights)
module monitoring 'modules/monitoring/logging.bicep' = {
  name: 'deploy-monitoring'
  params: {
    location: location
    tags: defaultTags
  }
}

// Deploy Communication (ACS)
module acs 'modules/communication/acs.bicep' = {
  name: 'deploy-acs'
  params: {
    acsName: acsName
    location: 'global' // ACS creates resources globally, but metadata is regional
    tags: defaultTags
  }
}

// Deploy Budget
module budget 'modules/cost/budget.bicep' = {
  name: 'deploy-budget'
  params: {
    contactEmails: budgetEmails
  }
}

// Deploy AI
module ai 'modules/ai/openai.bicep' = {
  name: 'deploy-ai'
  params: {
    location: 'eastus2' // Only available in certain regions
    accountName: 'openai-yggdrasil-main'
    tags: defaultTags
  }
}

// Deploy App 1 (Valhalla)
module valhalla 'modules/web/swa.bicep' = {
  name: 'deploy-valhalla'
  params: {
    location: 'eastasia' // Only available in certain regions
    appName: 'swa-valhalla'
    tags: defaultTags
  }
}

output valhallaHostname string = valhalla.outputs.defaultHostname

output cosmosEndpoint string = cosmos.outputs.accountEndpoint
output cosmosDatabaseName string = cosmos.outputs.databaseName
output appInsightsConnectionString string = monitoring.outputs.appInsightsConnectionString
output acsEndpoint string = acs.outputs.acsEndpoint
output openaiEndpoint string = ai.outputs.endpoint
