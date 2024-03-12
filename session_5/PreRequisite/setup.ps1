param(
    [string]$subscriptionId,
    [string]$location
)

az login --environment azureusgovernment
az account set --subscription $subscriptionId
$rg1 = $(az group create --name aks-rg --location $location)
$rg2 = $(az group create --name container-rg --location $location)
$sp1 = $(az ad sp create-for-rbac --name aks-terraform --role contributor --scopes /subscriptions/$subscriptionId/resourceGroups/aks-rg)
$sp2 = $(az ad sp create-for-rbac --name container-terraform --role contributor --scopes /subscriptions/$subscriptionId/resourceGroups/container-rg)
echo $sp1
echo $sp2