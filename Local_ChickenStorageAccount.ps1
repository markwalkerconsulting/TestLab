# .\Local_ChickenStorageAccount.ps1

#region ResourceGroupVariables
    $ResourceGroup = 'ChickenResGroup'
    $AzureLocation = 'East US' 
#endregion ResourceGroupVariables

#region CreateNewResourceGroup
    New-AzureRmResourceGroup -Name $ResourceGroup -Location $AzureLocation
#endregion CreateNewResourceGroup

#region ResourceVariables
    $ResourceName = 'chickensa'
    $LocalPath = 'C:\Users\MarkW\Documents\GitHub\ThunderChicken\Templates\ChickenStorageAccount.json'
    #$LocalParameterPath = 'C:\Users\MarkW\Documents\GitHub\ThunderChicken\Templates\ChickenStorageAccount.parameters.json'
#endregion ResourceVariables

#region PushResourceTemplate
    New-AzureRmResourceGroupDeployment -Name $ResourceName `
                                       -ResourceGroupName $ResourceGroup `
                                       -TemplateFile  $LocalPath 
                                      # -TemplateParameterFile $LocalParameterPath
#endregion PushResourceTemplate


