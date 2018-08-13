# .\drop_ChickenResGroup.ps1

#region Variables
    $ResourceGroup = 'ChickenResGroup'
#endregion Variables

#region RemoveResourceGroup
    Get-AzureRmResourceGroup -Name $ResourceGroup  | Remove-AzureRmResourceGroup -Verbose -Force
#endregion RemoveResourceGroup
