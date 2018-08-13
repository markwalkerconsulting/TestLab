# .\provision_VM.ps1

#region Variables
$ResourceGroup = "ThunderChickenTestLab"
$Location = "East US"
$nsgWName = 'nsgW'
$nsgVName = 'nsgV'
$nsgCName = 'nsgC'
$nsgKName = 'nsgK'
$subnetWName = 'subnetW'
$snAddressPrefixW = "10.0.1.0/24"
$subnetVName = 'subnetV'
$snAddressPrefixV = "10.0.2.0/24"
$subnetCName = 'subnetC'
$snAddressPrefixC = "10.0.3.0/24"
$subnetKName = 'subnetK'
$snAddressPrefixK = "10.0.4.0/24"
$vnetName = "iaasnetwork"
$vnAddressSpace = "10.0.0.0/16"
#endregion


#region Virtual Machines

    #region Domain Controller1
        #region Networking
          $nicDC1Name="nicDC1"
          # Public IP Address
          $pipDC1 = New-AzureRmPublicIpAddress -Name $nicDC1Name -ResourceGroupName $ResourceGroup `
                                            -Location $Location -AllocationMethod Dynamic
          $nic = New-AzureRmNetworkInterface -Name $nicDC1Name -ResourceGroupName $ResourceGroup `
                                             -Location $Location -SubnetId $vNet.Subnets[1].Id -PublicIpAddressId $pipDC1.Id
        #endregion Networking

        #region Credentials 
            $credDC1 = Get-Credential -Message "Enter Admin credentials:"
        #endregion Credentials
         
        #region Configuration 
            $vmDC1Name = "DC1"
            $vmDC1 = New-AzureRmVMConfig -VMName $vmDC1Name -VMSize "Basic_A1"
        #endregion Configuration
         
        #region OperatingSystem 
            $vm = Set-AzureRmVMOperatingSystem -VM $vmDC1 -Windows -ComputerName $vmDC1Name -Credential $credDC1 `
                                               -ProvisionVMAgent -EnableAutoUpdate

            $vm = Set-AzureRmVMSourceImage -VM $vmDC1 -PublisherName "MicrosoftWindowsServer" `
                                           -Offer "WindowsServer" -Skus "2012-R2-Datacenter" -Version "latest"
            
            $vm = Add-AzureRmVMNetworkInterface -VM $vm -Id $nic.Id

        #endregion OperatingSystem
         
        #region DiskSpace 
            $diskName = "os-disk"
            $storageAcc = Get-AzureRmStorageAccount -ResourceGroupName $resourceGroup -Name $storageAccountName
            $osDiskUri = $storageAcc.PrimaryEndpoints.Blob.ToString() + "vhds/" + $diskName  + ".vhd"
            $vm = Set-AzureRmVMOSDisk -VM $vm -Name $diskName -VhdUri $osDiskUri -CreateOption fromImage
        #endregion DiskSpace

        New-AzureRmVM -ResourceGroupName $ResourceGroup -Location $Location -VM $vm

    #endregion Domain Controller1


    #region Windows Servers


    #endregion Windows Servers


    #region Workstations


    #endregion Workstations


#endregion

