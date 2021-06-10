# Secure Web Application on Azure

> NOTE: This work in progress -not finalized yet.

This is a templated Terraform deployment of a secure web application, having all the related PaaS components deployed in a virtual network leveraging Private Endpoints.

The architecture of the solution is as depicted on the following diagram:

![Artitectural Diagram](./assets/azure-diagram.png?raw=true)

## The role of each component
* **Azure App Service** for hosting the web application, set up for a .NET application in this template
* **Azure Application Gateway (WAF)** to securely expose the web application to the internet, protecting it with a Web Application Firewall
* **Azure Key Vault** responsible to securely store the secrets/credentials for Service Bus/SQL Db/Storage Account
* **Application Insights** to provide monitoring and visibility for the health and performance of the application
* **Service Bus** a managed messaging broker service, accessible through the VNET via Private Endpoint
* **Azure SQL Database** the managed SQL Server database to be used by the application, accessible only through the private endpoint
* **Storage Account** the Storage Account that will contain the application data / blob files, Blob endpoint will be accessible through the private endpoint
* **Jumphost VM** the virtual machine to have access to the resources in the virtual network
* **Bastion Host** to allow RDP access to the Jumphost virtual machine over the Azure Portal

As an example, below are the resources created when running the deployment with project: 'secweb' and environment: 'test'

![Azure Resources](./assets/azure-resources.png?raw=true)