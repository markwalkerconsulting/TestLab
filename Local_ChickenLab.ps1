# .\Local_ChickenLab.ps1

#region ResourceGroupVariables
    $resourceGroup = 'ChickenResGroup'
    $azureLocation = 'East US'
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

#region ResourceVariables
    $deploymentName = 'chickenStuff'
    $localPath = 'C:\Users\MarkW\Documents\GitHub\ThunderChicken\Templates\ChickenLab.json'
    $localParameterPath = 'C:\Users\MarkW\Documents\GitHub\ThunderChicken\Templates\ChickenLab.parameters.json'
#endregion ResourceVariables

#region PushResourceTemplate mode=Complete
    New-AzureRmResourceGroupDeployment -Mode Complete `
                                       -Name $deploymentName `
                                       -ResourceGroupName $resourceGroup `
                                       -TemplateFile  $localPath `
                                       -TemplateParameterFile $localParameterPath
#endregion PushResourceTemplate mode=Complete

