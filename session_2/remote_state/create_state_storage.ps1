$suffix = "tf300session2"

$rg = New-AzResourceGroup -Name "rg-$suffix" -Location "eastus"

$sa = New-AzStorageAccount -ResourceGroupName $rg.ResourceGroupName -Name "sastate$suffix" -SkuName "Standard_LRS" -Location "eastus"

$ctx = New-AzStorageContext -StorageAccountName $sa.StorageAccountName -UseConnectedAccount

$container = New-AzStorageContainer -Name "fileshare-$suffix" -Context $ctx

# Remove-AzResourceGroup -Name "rg-$suffix" -Force -AsJob