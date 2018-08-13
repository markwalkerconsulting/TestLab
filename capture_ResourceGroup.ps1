# .\capture_ResourceGroup.ps1

#region Variables
$ResourceGroup = 'ChickenResGroup'
$Path = 'C:\Users\MarkW\Documents\GitHub\ThunderChicken\Templates\'
#endregion Variables

#Export Resource Group in Location to Path as an ARM Template(.json)
Export-AzureRmResourceGroup -ResourceGroupName $ResourceGroup `
                            -Path $Path
 

