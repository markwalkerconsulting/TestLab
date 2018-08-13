# .\Local_CallDeploy.ps1

#region ResourceVariables
    $Subscription_ID = '6b629d70-676c-4072-ad40-10cb47a07605'
    $ResourceGroup = 'ChickenResGroup'
    $AzureLocation = 'East US'
    $DName = 'DName'
    $ResourceName = 'ChickenLab'
    $LocalPath = 'C:\Users\MarkW\Documents\GitHub\ThunderChicken\Templates\' + $ResourceName + '.json'
    $LocalParametersPath = 'C:\Users\MarkW\Documents\GitHub\ThunderChicken\Templates\' + $ResourceName + '.parameters.json'
#endregion ResourceVariables

#region CreateNewResourceGroup
    New-AzureRmResourceGroup -Name $ResourceGroup -Location $AzureLocation
#endregion CreateNewResourceGroup

#region deployReource
    .\Deploy.ps1   -subscriptionId $Subscription_ID `
                   -resourceGroupName $ResourceGroup `
                   -resourceGroupLocation  $AzureLocation `
                   -deploymentName $DName `
                   -templateFilePath $LocalPath `
                   -parametersFilePath $LocalParametersPath
#endregion deployReource

