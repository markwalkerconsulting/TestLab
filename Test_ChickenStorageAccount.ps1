# .\Test_ChickenStorageAccount.ps1

#region ResourceGroupVariables
    $ResourceGroup = 'ChickenResGroup'
    $AzureLocation = 'East US' 
#endregion ResourceGroupVariables

#region CreateNewResourceGroup
    New-AzureRmResourceGroup -Name $ResourceGroup -Location $AzureLocation
#endregion CreateNewResourceGroup

#region ResourceVariables
    $ExternalPath = 'https://github.dxc.com/mwalker70/ThunderChicken/Templates/ChickenStorageAccount.json'
    $ExternalParameterPath = 'https://github.dxc.com/mwalker70/ThunderChicken/Templates/ChickenStorageAccount.parameters.json'
#endregion ResourceVariables

#region PushResourceTemplate
    Test-AzureRmResourceGroupDeployment -ResourceGroupName ChickenResGroup `
                                       -TemplateUri  https://github.dxc.com/mwalker70/ThunderChicken/Templates/ChickenStorageAccount.json `
                                       -TemplateParameterUri https://github.dxc.com/mwalker70/ThunderChicken/Templates/ChickenStorageAccount.parameters.json
#endregion PushResourceTemplate


