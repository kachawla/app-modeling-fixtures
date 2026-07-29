extension radius

resource pack 'Radius.Core/recipePacks@2025-08-01-preview' = {
  name: 'custom-recipe-pack'
  properties: {
    recipes: {
      'Radius.Resources/azureServiceBusNamespaces': {
        kind: 'bicep'
        source: 'mcr.microsoft.com/bicep/avm/res/service-bus/namespace:0.12.0'
        parameters: {
          name: '{{context.resource.name}}'
          disableLocalAuth: false
          skuObject: {
            name: 'Standard'
          }
          queues: [
            {
              name: '{{context.resource.properties.queueName}}'
            }
          ]
        }
        outputs: {
          secrets: {
            connectionString: 'primaryConnectionString'
          }
        }
      }
    }
  }
}
