extension radius
extension radiusCompute
extension radiusSecurity
extension radiusData

param environment string

@secure()
param password string

@description('The full container image reference to build and push. Must be lowercase.')
param image string

resource todoApp 'Applications.Core/applications@2023-10-01-preview' = {
  name: 'todo-list-app'
  properties: {
    environment: environment
  }
}

resource mysqlDb 'Radius.Data/mySqlDatabases@2025-08-01-preview' = {
  name: 'mysql'
  properties: {
    environment: environment
    application: todoApp.id
    database: 'todos'
    version: '8.0'
    secretName: mysqlSecret.name
  }
}

resource mysqlSecret 'Radius.Security/secrets@2025-08-01-preview' = {
  name: 'mysql-secret'
  properties: {
    environment: environment
    application: todoApp.id
    data: {
      USERNAME: {
        value: 'todo_user'
      }
      PASSWORD: {
        value: password
      }
    }
  }
}

resource todoImage 'Radius.Compute/containerImages@2025-08-01-preview' = {
  name: 'todo-list-app-image'
  properties: {
    environment: environment
    application: todoApp.id
    image: image
    build: {
      context: '.'
    }
  }
}

resource todoContainer 'Radius.Compute/containers@2025-08-01-preview' = {
  name: 'todo-list-app'
  properties: {
    environment: environment
    application: todoApp.id
    containers: {
      todo: {
        image: todoImage.properties.image
        ports: {
          web: {
            containerPort: 3000
          }
        }
      }
    }
    connections: {
      mysqldb: {
        source: mysqlDb.id
      }
      containerImage: {
        source: todoImage.id
      }
    }
  }
}
