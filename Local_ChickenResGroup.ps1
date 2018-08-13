# .\Local_ChickenResGroup.ps1

#region ResourceGroupVariables
    $ResourceGroup = 'ChickenResGroup'
    $AzureLocation = 'East US'
#endregion ResourceGroupVariables

#region Create or check for existing resource group
    $rGroup = Get-AzureRmResourceGroup -Name $resourceGroup -ErrorAction SilentlyContinue
    if(!$rGroup)
    {
        Write-Host -foregroundColor Green "Creating resource group: " $resourceGroup " in location: " $azureLocation
        New-AzureRmResourceGroup -Name $resourceGroup -Location $azureLocation
    }
    else{
        Write-Host -foregroundColor Green "Using existing resource group: '$resourceGroup'";
    }
#endregion Create or check for existing resource group

