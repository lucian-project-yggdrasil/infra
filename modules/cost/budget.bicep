param startDate string = utcNow('yyyy-MM-01') // Start of current month
param contactEmails array

resource budget 'Microsoft.Consumption/budgets@2023-11-01' = {
  name: 'yggdrasil-budget-main'
  properties: {
    timePeriod: {
      startDate: startDate
    }
    timeGrain: 'Monthly'
    amount: 2 // Strict $2.00 Limit
    category: 'Cost'
    notifications: {
      Warning: {
        enabled: true
        operator: 'GreaterThan'
        threshold: 25 // $0.50
        contactEmails: contactEmails
      }
      Critical: {
        enabled: true
        operator: 'GreaterThan'
        threshold: 75 // $1.50
        contactEmails: contactEmails
      }
      HardStop: {
        enabled: true
        operator: 'GreaterThan'
        threshold: 95 // $1.90
        contactEmails: contactEmails
      }
    }
  }
}
