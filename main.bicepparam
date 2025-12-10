using 'main.bicep'

param location = 'southeastasia'
param cosmosName = 'cosmos-yggdrasil-main'
param acsName = 'acs-yggdrasil-main'

param defaultTags = {
  Project: 'Yggdrasil'
  Environment: 'Prod'
  Owner: 'Lucian Barrios'
  ManagedBy: 'Bicep'
}

// PUBLIC PLACEHOLDERS
param budgetEmails = ['placeholder@example.com']
