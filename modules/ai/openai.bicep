param location string
param accountName string
param tags object = {}

// 1. The Account (The "Brain")
resource openai 'Microsoft.CognitiveServices/accounts@2023-05-01' = {
  name: accountName
  location: location
  kind: 'OpenAI'
  sku: {
    name: 'S0' // Standard Pay-as-you-go
  }
  properties: {
    customSubDomainName: accountName
    publicNetworkAccess: 'Enabled'
  }
  tags: tags
}

// 2. The Deployment (The "Model")
resource gpt4o 'Microsoft.CognitiveServices/accounts/deployments@2023-05-01' = {
  parent: openai
  name: 'gpt-4o' // This is the deployment name you use in code
  sku: {
    name: 'Standard'
    capacity: 10 // Token-per-minute quota (TPM) scale unit. 10 is fine for dev.
  }
  properties: {
    model: {
      format: 'OpenAI'
      name: 'gpt-4o'
      version: '2024-05-13' // Pin the version for stability
    }
    raiPolicyName: 'Microsoft.Default'
  }
}

output endpoint string = openai.properties.endpoint
