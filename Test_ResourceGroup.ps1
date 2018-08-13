# .\Test_ResourceGroup.ps1

#region Variables
    $sourceIsLocal = $false
    $resGroupName = 'ChickenResGroup'
    $tempFile = 'C:\Users\MarkW\Documents\GitHub\ThunderChicken\Templates\ChickenLab.json'
    $tempParametersFile = 'C:\Users\MarkW\Documents\GitHub\ThunderChicken\Templates\ChickenLab.parameters.json'
    $tempUri = 'https://github.dxc.com/mwalker70/ThunderChicken/Templates/ChickenLab.json'
    $tempParametersUri = 'https://github.dxc.com/mwalker70/ThunderChicken/Templates/ChickenLab.parameters.json'
#endregion Variables

#region RunTest
    If ($sourceIsLocal = $true) {
        # Test local ARMTemplate
        Write-Host -foregroundColor Green "Testing Local ARM Template:" 
        Test-AzureRmResourceGroupDeployment -ResourceGroupName $resGroupName `
                                            -TemplateParameterFile $tempParametersFile `
                                            -TemplateFile $tempFile 
    }
    else {
        # Test External ARMTemplate
        Write-Host -foregroundColor Green "Testing External ARM Template:" 
        Test-AzureRmResourceGroupDeployment -ResourceGroupName $resGroupName `
                                            -TemplateParameterUri $tempParametersUri `
                                            -TemplateUri $tempUri

                                           
    }
#endregion RunTest
