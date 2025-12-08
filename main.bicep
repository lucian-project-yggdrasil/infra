targetScope = 'resourceGroup'

param location string = resourceGroup().location
param cosmosName string = 'cosmos-yggdrasil-main'
param budgetEmails array

// Deploy Cosmos DB (The Memory)
module cosmos 'modules/data/cosmos.bicep' = {
  name: 'deploy-cosmos'
  params: {
    location: location
    accountName: cosmosName
  }
}

// Deploy Monitoring (Logs + App Insights)
module monitoring 'modules/monitoring/logging.bicep' = {
  name: 'deploy-monitoring'
  params: {
    location: location
  }
}

// Deploy Communication (ACS)
module acs 'modules/communication/acs.bicep' = {
  name: 'deploy-acs'
  params: {
    location: 'global' // ACS creates resources globally, but metadata is regional
  }
}

// Deploy Budget
module budget 'modules/cost/budget.bicep' = {
  name: 'deploy-budget'
  params: {
    contactEmails: budgetEmails
  }
}

output cosmosEndpoint string = cosmos.outputs.accountEndpoint
output cosmosDatabaseName string = cosmos.outputs.databaseName
output appInsightsConnectionString string = monitoring.outputs.appInsightsConnectionString
output acsEndpoint string = acs.outputs.acsEndpoint
