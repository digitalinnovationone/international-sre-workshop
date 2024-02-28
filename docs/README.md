# Preparing the repository

Antes de iniciar quaisquer atividades no repositório, é necessário efetuar algumas configurações no Github e também no Azure.

# Azure Configurations
When using the `azd CLI tool` and logging in with your Azure user, this user will be used by the CLI tool to carry out all procedures in the cloud environment, from creating resources, deleting them and even publishing new versions.

However, the correct way to connect to Azure is to specifically create a *Service Principal*, which is actually a "type" of user managed by Azure. This way we can limit Service Principal access in certain contexts.

This repository has a GitActions called `example-dispacher.yml`, which deploys a simple web app to Azure, using terraform. For this pipeline to work correctly, you will need to create a Service Principal and configure secrets and variables on GitHub. Creating the Service Principal is very simple. You can do this by following the steps described in the following link: [https://learn.microsoft.com/en-us/entra/identity-platform/howto-create-service-principal-portal](https://learn.microsoft.com/en-us/entra/identity-platform/howto-create-service-principal-portal).

Create the main service with the name `sp-dio-sre-dev` and note the `client_id`, `tenant_id`, `subscription_id` and `client_secret`. We will need this information to configure GitHub.

Additionally, add permissions for this main service to the subscription. The role must be `Contributor` using the following steps: [https://learn.microsoft.com/en-us/entra/identity-platform/howto-create-service-principal-portal#assign-a-role-to -the-application](https://learn.microsoft.com/en-us/entra/identity-platform/howto-create-service-principal-portal#assign-a-role-to-the-application)

Everything ready in Azure, now let's configure GitHub.

# GitHub Variables

The example GitActions depends on setting a few variables to work correctly.

You will need to create the following secrets and variables:

## Secrets
| Secret                | Value                              |
|-----------------------|------------------------------------|
| AZURE_CLIENT_ID       | `SERVICE_PRINCIPAL_CREATED_BEFORE` |
| AZURE_CLIENT_SECRET   | `SERVICE_PRINCIPAL_CREATED_BEFORE` |
| AZURE_SUBSCRIPTION_ID | `SUBSCRIPTION_ID`                  |
| AZURE_TENANT_ID       | `TENANT_ID`                        |

## Variables

For the variables, some default values were defined as a suggestion for the `Storage Account` that will be created in Azure, necessary to maintain the `State` of the terraform. Feel free to modify the values.

| Variable               | Value                  |
|------------------------|------------------------|
| BACKEND_CONTAINER_NAME | `tf-backend`           |
| BACKEND_KEY            | `dio-dev`              |
| BACKEND_RG_NAME        | `rg-dio-terraform-dev` |
| BACKEND_ST_NAME        | `sadiotftatedev`       |

The storage account can be created manually, before any pipeline execution. But if you prefer, you can use the following commands to create the Storage Account with the Azure CLI tool(change the variables before run it):

```bash

    az account set --subscription <SUBSCRIPTION_ID>
 
    az group create --name <RESOURCE_GROUP_NAME> --location westus

    az storage account create --resource-group <STORAGE_ACCOUNT_NAME> --name <BACKEND_ST_NAME> --sku Standard_LRS --encryption-services blob 
 
    az storage container create --name <BACKEND_CONTAINER_NAME> --account-name <STORAGE_ACCOUNT_NAME>
   
```
To configure variables and secrets on GitHub, follow these steps:

- Access the `Settings` tab
- Access the `Environments` option
- Click on the `New Environment` button
- Set the name to `dev`
- Click on `Configure Environment`
- On the new screen, add the variables and secrets according to the tables described previously

# Next Steps

