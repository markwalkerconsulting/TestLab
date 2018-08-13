# .\provision_ResourceGroup.ps1

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
    $vnetName = "tcnetwork"
    $vnAddressSpace = "10.0.0.0/16"
#endregion


#region Resource Group
    New-AzureRmResourceGroup -Name $ResourceGroup -Location $Location
#endregion


#region Storage Acount
    $StorageAccountName = "tcstorageaccount"
    New-AzureRmStorageAccount -Name $StorageAccountName -ResourceGroupName $ResourceGroup `
                              -Type Standard_LRS -Location $Location
#endregion


#region vNetworks, subnets (W, V, C, and K), and Network Security Groups
    #region SubnetW, nsgW, and ruleWxx:
     # Create an NSG rule to allow RDP(3389) traffic from the Internet to the subnetW
        $ruleW1 = New-AzureRmNetworkSecurityRuleConfig  -Name 'Allow-RDP-All' -Description "Allow RDP" `
                                                        -Access Allow -Protocol Tcp -Direction Inbound -Priority 200 `
                                                        -SourceAddressPrefix Internet -SourcePortRange * `
                                                        -DestinationAddressPrefix * -DestinationPortRange 3389

     # Create an NSG rule to allow HTTP(80) traffic in from the Internet to the subnetW
       $ruleW2 = New-AzureRmNetworkSecurityRuleConfig   -Name 'Allow-HTTP-All' -Description 'Allow HTTP' `
                                                        -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 `
                                                        -SourceAddressPrefix Internet -SourcePortRange * `
                                                        -DestinationAddressPrefix * -DestinationPortRange 80

      # Create a network security group for the subnetW
        $nsgW = New-AzureRmNetworkSecurityGroup -ResourceGroupName $ResourceGroup -Location $Location `
                                                -Name $nsgWName -SecurityRules $ruleW1,$ruleW2

      # Create subnetW
        $subnetW = New-AzureRmVirtualNetworkSubnetConfig  -Name $subnetWName -AddressPrefix $snAddressPrefixW  `
                                                          -NetworkSecurityGroup $nsgW
    #endregion SubnetW

    #region SubnetV, nsgV, and ruleVxx:
        # Create an NSG rule to allow RDP(3389) traffic from the Internet to the subnetV
          $ruleV1 = New-AzureRmNetworkSecurityRuleConfig -Name 'Allow-RDP-All' -Description "Allow RDP" `
                                                         -Access Allow -Protocol Tcp -Direction Inbound -Priority 200 `
                                                         -SourceAddressPrefix Internet -SourcePortRange * `
                                                         -DestinationAddressPrefix * -DestinationPortRange 3389

        # Create a network security group for the subnetV
          $nsgV = New-AzureRmNetworkSecurityGroup -ResourceGroupName $ResourceGroup -Location $Location `
                                                  -Name $nsgVName -SecurityRules $ruleV1

        # Create subnetV
          $subnetV = New-AzureRmVirtualNetworkSubnetConfig  -Name $subnetVName -AddressPrefix $snAddressPrefixV  `
                                                            -NetworkSecurityGroup $nsgV 
    #endregion SubnetV

    #region SubnetC, nsgC, and ruleCxx:
        # Create an NSG rule to allow RDP(3389) traffic from the Internet to the subnetC
          $ruleC1 = New-AzureRmNetworkSecurityRuleConfig -Name 'Allow-RDP-All' -Description "Allow RDP" `
                                                         -Access Allow -Protocol Tcp -Direction Inbound -Priority 200 `
                                                         -SourceAddressPrefix Internet -SourcePortRange * `
                                                         -DestinationAddressPrefix * -DestinationPortRange 3389

        # Create a network security group for the subnetC
          $nsgC = New-AzureRmNetworkSecurityGroup -ResourceGroupName $ResourceGroup -Location $Location `
                                                  -Name $nsgCName -SecurityRules $ruleC1

        # Create subnetC
          $subnetC = New-AzureRmVirtualNetworkSubnetConfig  -Name $subnetCName -AddressPrefix $snAddressPrefixC  `
                                                            -NetworkSecurityGroup $nsgC    
    #endregion SubnetC

    #region SubnetK, nsgK, and ruleKxx:
        # Create an NSG rule to allow RDP(3389) traffic from the Internet to the subnetK
          $ruleK1 = New-AzureRmNetworkSecurityRuleConfig -Name 'Allow-RDP-All' -Description "Allow RDP" `
                                                         -Access Allow -Protocol Tcp -Direction Inbound -Priority 200 `
                                                         -SourceAddressPrefix Internet -SourcePortRange * `
                                                         -DestinationAddressPrefix * -DestinationPortRange 3389

        # Create a network security group for the subnetK
          $nsgK = New-AzureRmNetworkSecurityGroup -ResourceGroupName $ResourceGroup -Location $Location `
                                                  -Name $nsgKName -SecurityRules $ruleK1

        # Create subnetK
          $subnetK = New-AzureRmVirtualNetworkSubnetConfig  -Name $subnetKName -AddressPrefix $snAddressPrefixK  `
                                                            -NetworkSecurityGroup $nsgK      
    #endregion SubnetK

    # Create vNetwork and add all subnets
      $vNet = New-AzureRmVirtualNetwork   -Name $vnetName -ResourceGroupName $ResourceGroup -Location $Location `
                                        -AddressPrefix $vnAddressSpace -Subnet $subnetW,$subnetV,$subnetC,$subnetK

#endregion vNetworks, subnets (W, V, C, and K), and Network Security Groups
