# azure-secure-website-tf
An typical secure website deployment on Azure via Terraform


## Disclaimer: WORK IN PROGRESS!!

# Secured Web Application on Azure

[![Deploy To Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fnianton%2Fazure-secure-website%2Fmain%2Fdeploy%2Fazure.deploy.json)

> NOTE: This work in progress -not finalized yet.

This is a templated deployment of a secure web application on Azure Functions, having all the related PaaS components deployed in a virtual network leveraging Private Endpoints.

The architecture of the solution is as depicted on the following diagram:

![Artitectural Diagram](./assets/azure-diagram.png?raw=true)

## The role of each component
* **Azure App Service** -responsible to manage the file tranfer with two approaches:
* **Azure Key Vault** responsible to securely store the secrets/credentials for AWS S3 and Az Data Storage Account
* **Application Insights** to provide monitoring and visibility for the health and performance of the application
* **Service Bus** a managed messaging broker service, accessible through the VNET via Private Endpoint
* **Azure Database for MySQL** the managed MySQL database to be used by the applications
* **Data Storage Account** the Storage Account that will contain the application data / blob files
* **Jumphost VM** the virtual machine to have access to the resources in the virtual network
