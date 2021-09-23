$subs = Get-AzSubscription 
foreach ($Sub in $Subs) {
    Write-Host "***************************"
    Write-Host " "
    $Sub.Name 

    $SelectSub = Select-AzSubscription -SubscriptionName $Sub.Name

    $VNETs = Get-AzVirtualNetwork 
    foreach ($VNET in $VNETs) {
        Write-Host "--------------------------"
        Write-Host " "
        Write-Host "   vNet: " $VNET.Name 
        Write-Host "   AddressPrefixes: " ($VNET).AddressSpace.AddressPrefixes

        $vNetExpanded = Get-AzVirtualNetwork -Name $VNET.Name -ResourceGroupName $VNET.ResourceGroupName -ExpandResource 'subnets/ipConfigurations' 

        foreach($subnet in $vNetExpanded.Subnets)
        {
            Write-Host "       Subnet: " $subnet.Name
            Write-Host "          Connected devices " $subnet.IpConfigurations.Count
            foreach($ipConfig in $subnet.IpConfigurations)
            {
                Write-Host "            " $ipConfig.PrivateIpAddress
            }
        }

        Write-Host " " 
    } 
}