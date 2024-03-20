<#
 .SYNOPSIS
    This script is used to create the required resources for the session 5 of the workshop.
 .DESCRIPTION
    This script creates 2 resource groups, 2 service principals and sets the required permissions for the service principals.
 .PARAMETER subscriptionId
    The subscription id where the resources will be created.
 .PARAMETER location
    The location where the resources will be created.
 .PARAMETER environment
    The environment where the resources will be created. suggested values are AzureCloud, AzureChinaCloud, AzureGermanCloud, AzureUSGovernment.
 .EXAMPLE
    .\setup.ps1 -subscriptionId "00000000-0000-0000-0000-000000000000" -location "eastus" -environment "AzureCloud"
    This command will create the required resources in the subscription with id "00000000-0000-0000-0000-000000000000" in the location "eastus" in the AzureCloud environment.
 .LINK
    https://www.youtube.com/watch?v=dQw4w9WgXcQ
#>

param(
    [string]$subscriptionId,
    [string]$location,
    [string]$environment
)

az cloud set --name $environment
az login
az account set --subscription $subscriptionId
$rg1 = $(az group create --name aks-rg --location $location)
$rg2 = $(az group create --name container-rg --location $location)
$sp1 = $(az ad sp create-for-rbac --name aks-terraform --role contributor --scopes /subscriptions/$subscriptionId/resourceGroups/aks-rg)
$sp2 = $(az ad sp create-for-rbac --name container-terraform --role contributor --scopes /subscriptions/$subscriptionId/resourceGroups/container-rg)
echo $sp1
echo $sp2