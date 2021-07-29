### --- PUBLIC FUNCTIONS --- ###
#Region - Get-SCMrkClient.ps1
function Get-SCMrkClient {
    <#
    .SYNOPSIS
        Cmdlet for retrieving data on a specific client
    .DESCRIPTION
        Cmdlet which retrieves a PS Object with data on a specific client on a specific network
    .EXAMPLE
        PS C:\> Get-SCMrkClient -Id "<network_id>" -ClientId "<client_id>"

        This cmdlet will retrieve a PS Object on a specific client, defined by the -ClientId,
        on a specific Network defined by -Id
    .PARAMETER Id
        Network Id for the network which the client is associated with
    .PARAMETER ClientId
        Client Id of the client you want to retrieve data on
    .PARAMETER ApiKey
        ApiKey for Meraki Dashboard. Check following Meraki Docs to see how to get a Dashboard API Key:
        https://documentation.meraki.com/General_Administration/Other_Topics/Cisco_Meraki_Dashboard_API#:~:text=For%20access%20to%20the%20API,to%20generate%20an%20API%20key.
    .INPUTS
        System.String[] - You can pipe the Id (network id) into the cmdlet
        System.String[] - You can pipe the ClientId (Client Id) into the cmdlet
    .OUTPUTS
        System.Object[] - This cmdlet will output a PS Object with data on the specific client defined.
    .NOTES
        Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!get-network-client
    .Link
        Online Help: https://scriptingchris.tech
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$Id,
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [ValidateLength(5,7)]
        [String]$ClientId,
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$ApiKey = $ApiKey
    )

    Begin {
        Write-Verbose -Message "Initiating retrieval of Client: $($ClientId)"
        Write-Verbose -Message "Initiating retrieval of Client from Network: $($Id)"
    }

    Process {
        try {
            Write-Verbose -Message "Retrieving Meraki Client"
            $result = Invoke-PRMerakiApiCall -Method GET -Resource "/networks/$($Id)/clients/$($ClientId)" -ApiKey $ApiKey
            Write-Output -InputObject $result
        }
        catch {
            $statusCode = $_.Exception.Response.StatusCode.value__
            $statusDescription = $_.Exception.Response.StatusDescription
        }
    }

    End {
        if($statusCode){
            Write-Error -Message "Status code: $($statusCode), Error Description: $($statusDescription)"
        }
    }
}
Export-ModuleMember -Function Get-SCMrkClient
#EndRegion - Get-SCMrkClient.ps1
#Region - Get-SCMrkDevice.ps1
function Get-SCMrkDevice {
    <#
    .SYNOPSIS
        Cmdlet for retriving information on a specific Meraki device
    .DESCRIPTION
        Cmdlet which will retrieve a PS Object of information on a specific Meraki Device
    .EXAMPLE
        PS C:\> Get-SCMrkDevice -Serial "<serial_number>"

        This example will retrieve a PS Object of the device specified by the serial number
        provided in the parameter -Serial
    .EXAMPLE
        (Get-SCMrkDevices -Id "<network_id>" | ? Name -eq "Device1").Serial | Get-SCMrkDevice

        This example will grap the serial through the pipeline and return an PS Object of the
        specified device.
    .PARAMETER Serial
        The Serial number for a specific Cisco Meraki device.
    .PARAMETER ApiKey
        ApiKey for Meraki Dashboard. Check following Meraki Docs to see how to get a Dashboard API Key:
        https://documentation.meraki.com/General_Administration/Other_Topics/Cisco_Meraki_Dashboard_API#:~:text=For%20access%20to%20the%20API,to%20generate%20an%20API%20key.
    .INPUTS
        System.String[] - You can pipe the Serial into the cmdlet
    .OUTPUTS
        System.Object[] - This cmdlet will output a PS Object with data on the specific device.
    .NOTES
        Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!get-device
    .Link
        Online Help: https://scriptingchris.tech
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$Serial,
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$ApiKey = $ApiKey
    )

    Begin {
        Write-Verbose -Message "Initiating retrieval of all device: $($Serial)"
    }

    Process {
        try {
            Write-Verbose -Message "Retrieving Meraki Device"
            $result = Invoke-PRMerakiApiCall -Method GET -Resource "/devices/$($Serial)" -ApiKey $ApiKey
            Write-Output -InputObject $result
        }
        catch {
            $statusCode = $_.Exception.Response.StatusCode.value__
            $statusDescription = $_.Exception.Response.StatusDescription
        }
    }

    End {
        if($statusCode){
            Write-Error -Message "Status code: $($statusCode), Error Description: $($statusDescription)"
        }
    }
}
Export-ModuleMember -Function Get-SCMrkDevice
#EndRegion - Get-SCMrkDevice.ps1
#Region - Get-SCMrkDeviceClients.ps1
function Get-SCMrkDeviceClients {
    <#
    .SYNOPSIS
        Cmdlet for retrieving all clientes associated to a specific device
    .DESCRIPTION
        This cmdlet will retrieve all the clients which are or have been connected to a specific device
    .EXAMPLE
        PS C:\> Get-SCMrkDeviceClients -Serial "<serial_number>"

        This example will return all the clients that are or have been connected, the last 24 hours,
        to a specific Cisco Meraki device.
    .EXAMPLE
        PS C:\> (Get-SCMrkDevices -Id "<network_id>" | ? Name -eq "Device1").Serial | Get-SCMrkDeviceClients

        This example will grap the serial fnumber from the pipeline and retrieve all the clients connected to the
        specific device.
    .PARAMETER Serial
        The Serial number for a specific Cisco Meraki device.
    .PARAMETER ApiKey
        ApiKey for Meraki Dashboard. Check following Meraki Docs to see how to get a Dashboard API Key:
        https://documentation.meraki.com/General_Administration/Other_Topics/Cisco_Meraki_Dashboard_API#:~:text=For%20access%20to%20the%20API,to%20generate%20an%20API%20key.
    .INPUTS
        System.String[] - You can pipe the Serial into the cmdlet
    .OUTPUTS
        System.Array - The cmdlet will output an PS Object with an array of all the clients associated to a specific device.
    .NOTES
        Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!get-device-clients
    .Link
        Online Help: https://scriptingchris.tech
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$Serial,
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$ApiKey = $ApiKey
    )

    Begin {
        Write-Verbose -Message "Initiating retrieval of all clients associated to device: $($Serial)"
    }

    Process {
        try {
            Write-Verbose -Message "Retrieving Meraki Device Clients"
            $result = Invoke-PRMerakiApiCall -Method GET -Resource "/devices/$($Serial)/clients" -ApiKey $ApiKey
            Write-Output -InputObject $result
        }
        catch {
            $statusCode = $_.Exception.Response.StatusCode.value__
            $statusDescription = $_.Exception.Response.StatusDescription
        }
    }

    End {
        if($statusCode){
            Write-Error -Message "Status code: $($statusCode), Error Description: $($statusDescription)"
        }
    }
}
Export-ModuleMember -Function Get-SCMrkDeviceClients
#EndRegion - Get-SCMrkDeviceClients.ps1
#Region - Get-SCMrkL3FirewallRules.ps1
function Get-SCMrkL3FirewallRules {
    <#
    .SYNOPSIS
        Cmdlet for retrieving all L3 firewall rules for a network
    .DESCRIPTION
        This cmdlet will return an Array of all L3 firewall rules configured on a network
    .EXAMPLE
        PS C:\> Get-SCMrkL3FirewallRules -Id L_918231134598135
        
        This example will return all L3 firewall rules configured for the network with Id
        L_918231134598135.
    .NOTES
        Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!get-network-appliance-firewall-l-3-firewall-rules
    .LINK
        Online Help: https://scriptingchris.tech
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$Id,
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$ApiKey = $ApiKey
    )

    Begin {
        Write-Verbose -Message "Initiating retrieval of all L3 Firewall Rules associated to the network: $($Id)"
    }

    Process {
        try {
            Write-Verbose -Message "Retrieving Meraki L3 Firewall Rules"
            $result = Invoke-PRMerakiApiCall -Method GET -Resource "/networks/$($Id)/appliance/firewall/l3FirewallRules" -ApiKey $ApiKey
            Write-Output -InputObject $result.rules
        }
        catch {
            $statusCode = $_.Exception.Response.StatusCode.value__
            $statusDescription = $_.Exception.Response.StatusDescription
        }
    }

    End {
        if($statusCode){
            Write-Error -Message "Status code: $($statusCode), Error Description: $($statusDescription)"
        }
    }
}
Export-ModuleMember -Function Get-SCMrkL3FirewallRules
#EndRegion - Get-SCMrkL3FirewallRules.ps1
#Region - Get-SCMrkNetworkDevices.ps1
function Get-SCMrkNetworkDevices {
    <#
    .SYNOPSIS
        Cmdlet for retrieving all (meraki)devices on a network
    .DESCRIPTION
        Cmdlet which will retrieve a PS Object with an array of all the networks claimed and added
        to a specific network
    .EXAMPLE
        PS C:\> Get-SCMrkDevices -Id "<network_id>"

        This example will retrive all the networks located on the network with the "<network_id>" you
        provided the in the parameter Id.
    .EXAMPLE
        PS C:\> (Get-SCMrkNetworks | ? Name -eq "Network1").Id | Get-SCMrkNetworkDevices

        This example will grap the id of the network with name "Network1" through the pipeline and
        return all the (network)devices on that specific network.
    .PARAMETER Id
        Network Id from the network you want to retrive the devices from.
    .PARAMETER ApiKey
        ApiKey for Meraki Dashboard. Check following Meraki Docs to see how to get a Dashboard API Key:
        https://documentation.meraki.com/General_Administration/Other_Topics/Cisco_Meraki_Dashboard_API#:~:text=For%20access%20to%20the%20API,to%20generate%20an%20API%20key.
    .INPUTS
        System.String[] - You can pipe the Id(network id) into the cmdlet
    .OUTPUTS
        System.Array[] - The cmdlet will output an PS Object with an array of all the devices on the network.
    .NOTES
        Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!get-network-devices
    .Link
        Online Help: https://scriptingchris.tech
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$Id,
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$ApiKey = $ApiKey
    )

    Begin {
        Write-Verbose -Message "Initiating retrieval of all devices associated to the network: $($Id)"
    }

    Process {
        try {
            Write-Verbose -Message "Retrieving Meraki Networks"
            $result = Invoke-PRMerakiApiCall -Method GET -Resource "/networks/$($Id)/devices" -ApiKey $ApiKey
            Write-Output -InputObject $result
        }
        catch {
            $statusCode = $_.Exception.Response.StatusCode.value__
            $statusDescription = $_.Exception.Response.StatusDescription
        }
    }

    End {
        if($statusCode){
            Write-Error -Message "Status code: $($statusCode), Error Description: $($statusDescription)"
        }
    }
}
Export-ModuleMember -Function Get-SCMrkNetworkDevices
#EndRegion - Get-SCMrkNetworkDevices.ps1
#Region - Get-SCMrkNetworks.ps1
function Get-SCMrkNetworks {
    <#
    .SYNOPSIS
        Cmdlet for retrieving all networks in an Meraki Organisation.
    .DESCRIPTION
        This cmdlet will retrieve a powershell object with information on all
        the networks in your Meraki Organisation.
    .EXAMPLE
        PS C:\> Get-SCMrkNetworks -OrgId "<organisation_id>" -ApiKey "<api_key>"

        This example will take an ApiKey and an Organisation Id and retrieve all networks
        in that organisation.
    .EXAMPLE
        PS C:\> Get-SCMrkNetworks

        If you have already run Set-SCMrkAuth, then you will not need to provide any
        other parameters for retriving networks in that organisation you specified in
        Set-MrkAuth.
    .PARAMETER OrgId
        Organisation id of the specific organisation you want to see the devices from.
        If you have run Set-SCMrkAuth before running this cmdlet the parameter is not necessary.
    .PARAMETER ApiKey
        ApiKey for Meraki Dashboard. Check following Meraki Docs to see how to get a Dashboard API Key:
        https://documentation.meraki.com/General_Administration/Other_Topics/Cisco_Meraki_Dashboard_API#:~:text=For%20access%20to%20the%20API,to%20generate%20an%20API%20key.
    .INPUTS
        System.String[] - You can pipe OrgId as a string into the cmdlet.
    .OUTPUTS
        System.Array[] - The cmdlet will output an PS Object with an array of all the networks.
    .NOTES
        Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!get-organization-networks
    .Link
        Online Help: https://scriptingchris.tech
    #>

    [CmdletBinding()]
    [Alias('scgn')]
    param (
        [Parameter(Mandatory=$false, valueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$OrgId = $OrgId,
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$ApiKey = $ApiKey
    )

    Begin {
        Write-Verbose -Message "Initiating retrievel of Meraki Networks in Organisation: $($OrgId)"
    }

    Process {
        try {
            Write-Verbose -Message "Retrieving Meraki Networks"
            $result = Invoke-PRMerakiApiCall -Method GET -Resource "/organizations/$($OrgId)/networks" -ApiKey $ApiKey
            Write-Output -InputObject $result
        }
        catch {
            $statusCode = $_.Exception.Response.StatusCode.value__
            $statusDescription = $_.Exception.Response.StatusDescription
        }
    }

    End {
        if($statusCode){
            Write-Error -Message "Status code: $($statusCode), Error Description: $($statusDescription)"
        }
    }
}
Export-ModuleMember -Function Get-SCMrkNetworks
#EndRegion - Get-SCMrkNetworks.ps1
#Region - Get-SCMrkNetworkSNMP.ps1
function Get-SCMrkNetworkSNMP {
    <#
    .SYNOPSIS
        Cmdlet for retrieving SNMP configurations of a network
    .DESCRIPTION
        This cmdlet will query a specific network and output the SNMP configurations from it
    .EXAMPLE
        PS C:\> Get-SCMrkNetworkSNMP -Id L_918231134598135
        
        This example will retrieve the SNMP configurations from the network L_918231134598135
    .NOTES
        Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!get-network-snmp
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$Id,
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$ApiKey = $ApiKey
    )

    Begin {
        Write-Verbose -Message "Initiating retrieval of snmp configurations for the network: $($Id)"
    }

    Process {
        try {
            Write-Verbose -Message "Retrieving Meraki Network snmp config"
            $result = Invoke-PRMerakiApiCall -Method GET -Resource "/networks/$($Id)/snmp" -ApiKey $ApiKey
            Write-Output -InputObject $result
        }
        catch {
            $statusCode = $_.Exception.Response.StatusCode.value__
            $statusDescription = $_.Exception.Response.StatusDescription
        }
    }

    End {
        if($statusCode){
            Write-Error -Message "Status code: $($statusCode), Error Description: $($statusDescription)"
        }
    }
}
Export-ModuleMember -Function Get-SCMrkNetworkSNMP
#EndRegion - Get-SCMrkNetworkSNMP.ps1
#Region - Get-SCMrkNetworkVlans.ps1
function Get-SCMrkNetworkVlans {
    <#
    .SYNOPSIS
        Cmdlet for retrieving all Network Vlans and Subnets.
    .DESCRIPTION
        Cmdlet which will retrieve an array of object containing each subnet or vlan configured on a
        Meraki network.
    .EXAMPLE
        PS C:\> Get-SCMrkNetworkVlans -Id L_918231134598135
        
        This example will return an array of all the vlans configured on the network with
        Id L_918231134598135.
    .EXAMPLE
        PS C:\> (Get-SCMrkNetworks | ? name -eq "TEST-NETWORK").Id | Get-SCMrkNetworkVlans

        This example will pass the id of the network: TEST-NETWORK into the cmdlet Get-SCMrkNetworkVlans
        and retrieve all the vlans for that specific network.
    .INPUTS
        System.String[] - You can pipe the Id(network id) into the cmdlet
    .OUTPUTS
        System.Array[] - The cmdlet will output an PSObject with an array of all the vlans
    .NOTES
        Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!get-network-appliance-vlans
    .Link
        Online Help: https://scriptingchris.tech
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$Id,
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$ApiKey = $ApiKey
    )

    Begin {
        Write-Verbose -Message "Initiating retrieval of all vlans associated to the network: $($Id)"
    }

    Process {
        try {
            Write-Verbose -Message "Retrieving Meraki Network Vlans"
            $result = Invoke-PRMerakiApiCall -Method GET -Resource "/networks/$($Id)/appliance/vlans" -ApiKey $ApiKey
            Write-Output -InputObject $result
        }
        catch {
            $statusCode = $_.Exception.Response.StatusCode.value__
            $statusDescription = $_.Exception.Response.StatusDescription
        }
    }

    End {
        if($statusCode){
            Write-Error -Message "Status code: $($statusCode), Error Description: $($statusDescription)"
        }
    }
}
Export-ModuleMember -Function Get-SCMrkNetworkVlans
#EndRegion - Get-SCMrkNetworkVlans.ps1
#Region - Get-SCMrkSwitchPort.ps1
function Get-SCMrkSwitchPort {
    <#
    .SYNOPSIS
        Cmdlet for retriving confiurations on a switch port
    .DESCRIPTION
        Cmdlet for retriving configurations on a specific Meraki Switch port.
    .EXAMPLE
        PS C:\> Get-SCMrkSwitchPort -Serial "<serial_number>" -PortId "<port_id>"

        This example will retrieve the configurations on a specific Meraki switch port.
    .EXAMPLE
        PS C:\> (Get-SCMrkDevices -Id "<network_id>" | ? Name -eq "Device1").Serial | Get-SCMrkswitchPort -PortId 1

        This example will grap the serial from the pipeline and retrieve the configuratoins on switch port 1
    .PARAMETER Serial
        The Serial number for a specific Cisco Meraki device.
    .PARAMETER PortId
        The port id on the Meraki switch
    .PARAMETER ApiKey
        ApiKey for Meraki Dashboard. Check following Meraki Docs to see how to get a Dashboard API Key:
        https://documentation.meraki.com/General_Administration/Other_Topics/Cisco_Meraki_Dashboard_API#:~:text=For%20access%20to%20the%20API,to%20generate%20an%20API%20key.
    .INPUTS
        System.String[] - You can pipe the Serial into the cmdlet
        System.String[] - You can pipe the PortId into the cmdlet
    .OUTPUTS
        System.Object[] - This cmdlet will output a PS Object with data on the Switch port
    .NOTES
        https://developer.cisco.com/meraki/api-v1/#!get-device-switch-port
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$Serial,
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$PortId,
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$ApiKey = $ApiKey
    )

    Begin {
        Write-Verbose -Message "Initiating retrieval of switch port: $($PortId) on switch: $($Serial)"
    }

    Process {
        try {
            Write-Verbose -Message "Retrieving Meraki Switch Ports"
            $result = Invoke-PRMerakiApiCall -Method GET -Resource "/devices/$($Serial)/switch/ports/$($PortId)" -ApiKey $ApiKey
            Write-Output -InputObject $result
        }
        catch {
            $statusCode = $_.Exception.Response.StatusCode.value__
            $statusDescription = $_.Exception.Response.StatusDescription
        }
    }

    End {
        if($statusCode){
            Write-Error -Message "Status code: $($statusCode), Error Description: $($statusDescription)"
        }
    }
}
Export-ModuleMember -Function Get-SCMrkSwitchPort
#EndRegion - Get-SCMrkSwitchPort.ps1
#Region - Get-SCMrkSwitchPorts.ps1
function Get-SCMrkSwitchPorts {
    <#
    .SYNOPSIS
        Cmdlet for retriving all Switch ports from a Meraki switch
    .DESCRIPTION
        Cmdlet which retrieves configuration data on all switch ports of a Meraki Switch.
    .EXAMPLE
        PS C:\> Get-SCMrkSwitchPorts -Serial "<serial_number>"

        This example will retrieve data from all ports on a Meraki Switch.
    .EXAMPLE
        PS C:\> (Get-SCMrkDevices -Id "<network_id>" | ? Name -eq "Device1").Serial | Get-SCMrkSwitchPorts

        This example will grap the Meraki Switch Serial number and pipe it into the cmdlet, to retrieve data
        on all the Meraki switch ports.
    .PARAMETER Serial
        The Serial number for a specific Cisco Meraki device.
    .PARAMETER ApiKey
        ApiKey for Meraki Dashboard. Check following Meraki Docs to see how to get a Dashboard API Key:
        https://documentation.meraki.com/General_Administration/Other_Topics/Cisco_Meraki_Dashboard_API#:~:text=For%20access%20to%20the%20API,to%20generate%20an%20API%20key.
    .INPUTS
        System.String[] - You can pipe the Serial into the cmdlet
    .OUTPUTS
        System.Object[] - This cmdlet will output a PS Object with data on the specific device.
    .NOTES
        Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!get-device-switch-ports
    .LINK
        Online Help: https://scriptingchris.tech
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$Serial,
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$ApiKey = $ApiKey
    )

    Begin {
        Write-Verbose -Message "Initiating retrieval of Switch ports of switch: $($Serial)"
    }

    Process {
        try {
            Write-Verbose -Message "Retrieving Meraki Switch Ports"
            $result = Invoke-PRMerakiApiCall -Method GET -Resource "/devices/$($Serial)/switch/ports" -ApiKey $ApiKey
            Write-Output -InputObject $result
        }
        catch {
            $statusCode = $_.Exception.Response.StatusCode.value__
            $statusDescription = $_.Exception.Response.StatusDescription
        }
    }

    End {
        if($statusCode){
            Write-Error -Message "Status code: $($statusCode), Error Description: $($statusDescription)"
        }
    }
}
Export-ModuleMember -Function Get-SCMrkSwitchPorts
#EndRegion - Get-SCMrkSwitchPorts.ps1
#Region - Set-SCMrkAuth.ps1
function Set-SCMrkAuth {
    <#
    .SYNOPSIS
        Cmdlet for connecting to Meraki Dashboard API.
    .DESCRIPTION
        Cmdlet whitch which will authenticate your API key with Meraki Dashboard
        The cmdlet is necessary for not having to provide the API Key for the
        follwing cmdlets you will use.
    .EXAMPLE
        PS C:\> Set-SCMrkAuth -ApiKey "<api_key>"
        
        This example will connect to the Meraki Dashboard API. If you have multiple Organisations
        attached to your API key, the cmdlet will atumatically connect you to the firs Organisation.
    .EXAMPLE
        PS C:\> Set-SCMrkAuth -ApiKey "<api_key>" -OrgId "<organisation_id>"

        This examplel will connect you to the Merakii Dashboard API, and to the specific organisation
        specified with the parameter OrgId
    .PARAMETER ApiKey
        ApiKey for Meraki Dashboard. Check following Meraki Docs to see how to get a Dashboard API Key:
        https://documentation.meraki.com/General_Administration/Other_Topics/Cisco_Meraki_Dashboard_API#:~:text=For%20access%20to%20the%20API,to%20generate%20an%20API%20key.
    .PARAMETER OrgId
        Organisation Id for the specific Organisation you want to connect to. If you only have a single
        organisation, you can skip this parameter. If you have multiple Organisations but don't provide
        an organisation id the cmdlet will automatically connect you to the first organisation it
        retrieves.
    .INPUTS
        System.String[] - You can pipe the ApiKey as a string into the cmdlet
    .OUTPUTS
        System.String[] - The cmdlet returns a string with successfull statement, if connection was successfull
    .NOTES
        n/a
    .Link
        Online Help: https://scriptingchris.tech
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, HelpMessage="Please provide and API Key:", ValueFromPipeline=$true)]
        [ValidateLength(38,41)]
        [String]$ApiKey,
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$OrgId
    )

    Begin {
        Write-Verbose -Message "Initiating Meraki Dashboard Authentication with ApiKey: $($ApiKey)"
    }

    Process {
        if(!($OrgId)){
            Write-Verbose -Message "Authenticating to Meraki Dashboard API"
            try {
                $OrgId = Invoke-PRMerakiApiCall -Method GET -Resource "/organizations" -ApiKey $ApiKey | Select-Object -ExpandProperty Id -First 1
                Write-Verbose -Message "Setting the OrgId: $($OrgId) Variable as Script Scope"
                New-Variable -Name OrgId -Value $OrgId.ToString() -Scope Script -Force
                Write-Output -InputObject "Successfully conncted to Meraki API!"
            }
            catch {
                $statusCode = $_.Exception.Response.StatusCode.value__
                $statusDescription = $_.Exception.Response.StatusDescription
            }
        }
        elseif($OrgId){
            Write-Verbose -Message "Validating Organisation Id provided in parameter agains Meraki Dashboard API"
            try {
                $OrgIds = Invoke-PRMerakiApiCall -Method GET -Resource "/organizations" -ApiKey $ApiKey | Select-Object -ExpandProperty Id
                if($OrgIds -contains $OrgId){
                    Write-Verbose -Message "Setting the OrgId: $($Orgid) Variable as Script Scope"
                    New-Variable -Name OrgId -Value $OrgId.ToString() -Scope Script -Force
                    Write-Output -InputObject "Successfully conncted to Meraki API!"
                }
                else {
                    $statusCode = $_.Exception.Response.StatusCode.value__
                    $statusDescription = "Organisation Id provided in Parameter, was not found in your Meraki Dashboard"
                }
            }
            catch {
                $statusCode = $_.Exception.Response.StatusCode.value__
                $statusDescription = $_.Exception.Response.StatusDescription
            }
        }
    }

    End {
        if($statusCode){
            Write-Error -Message "Status code: $($statusCode), Error Description: $($statusDescription)"
        }
    }
}
Export-ModuleMember -Function Set-SCMrkAuth
#EndRegion - Set-SCMrkAuth.ps1
#Region - Set-SCMrkL3FirewallRule.ps1
function Set-SCMrkL3FirewallRule {
    <#
    .SYNOPSIS
        Cmdlet for adding a new L3 firewall rule to a network
    .DESCRIPTION
        This cmdlet will query all the existing L3 firewall rules and add a new rule to the list.
        You can chose to place the rule either on top or in the bottom of the list.
    .EXAMPLE
        PS C:\> $SplatArgs = @{
            Comment = "TEST - Allow snmp"
            Policy = "allow"
            Protocol = "udp"
            SourcePort = "161"
            SourceAddress = "any"
            DestinationPort = "161"
            DestinationAddress = "192.168.137.1"
            PlaceOnTop = $true
        }
        Set-SCMrkL3FirewallRule -Id $id @SplatArgs -Verbose

        This example will create a new firewall named "TEST - Allow snmp" In this example the rule is beeing
        passed to the cmdlet with splatting. You can also run the cmdlet in the conventional way.
        In this specific example the new rule will be placed in the top of all the rules. To specify that the 
        rule should be placed in the bottom you can define -PlaceOnTop as $false or not define it at all.
    .NOTES
        Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!update-network-appliance-firewall-l-3-firewall-rules
    .LINK
        Online Help: https://scriptingchris.tech
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$Id,
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$ApiKey = $ApiKey,
        [Parameter(Mandatory=$true)]
        [String]$Comment,
        [Parameter(Mandatory=$true)]
        [ValidateSet("allow", "deny")]
        [String]$Policy,
        [Parameter(Mandatory=$true)]
        [ValidateSet("any","tcp","udp","icmp")]
        [String]$Protocol,
        [Parameter(Mandatory=$true)]
        [String]$SourcePort,
        [Parameter(Mandatory=$true)]
        [String]$SourceAddress,
        [Parameter(Mandatory=$true)]
        [String]$DestinationPort,
        [Parameter(Mandatory=$true)]
        [String]$DestinationAddress,
        [Parameter(Mandatory=$false)]
        [String]$SyslogEnabled = "false",
        [Parameter(Mandatory=$false)]
        [Boolean]$PlaceOnTop = $false
    )

    Begin {
        Write-Verbose -Message "Creating new PS Object containing the new rule"
        $NewRulesObject = New-Object -TypeName PSObject -property @{
            "comment"       = "$($Comment)"
            "policy"        = "$($Policy)"
            "protocol"      = "$($Protocol)"
            "srcPort"       = "$($SourcePort)"
            "srcCidr"       = "$($SourceAddress)"
            "destPort"      = "$($DestinationPort)"
            "destCidr"      = "$($DestinationAddress)"
            "syslogEnabled" = "$($SyslogEnabled)"
        }

        if($NewRulesObject) {
            Write-Verbose -Message "Describing New Rules Object:"
            Write-Verbose -Message "Generating object comment: $($NewRulesObject.comment)"
            Write-Verbose -Message "Generating object policy: $($NewRulesObject.policy)"
            Write-Verbose -Message "Generating object protocol: $($NewRulesObject.protocol)"
            Write-Verbose -Message "Generating object srcPort: $($NewRulesObject.srcPort)"
            Write-Verbose -Message "Generating object srcCidr: $($NewRulesObject.srcCidr)"
            Write-Verbose -Message "Generating object destPort: $($NewRulesObject.destPort)"
            Write-Verbose -Message "Generating object destCidr: $($NewRulesObject.destCidr)"
            Write-Verbose -Message "Generating object syslogEnabled: $($NewRulesObject.syslogEnabled)"
        }
    }

    Process {
        Write-Verbose -Message "Querying dashboard for old L3 Firewall Rules Object"
        $OldRulesObject = Invoke-PRMerakiApiCall -Method GET -Resource "/networks/$($Id)/appliance/firewall/l3FirewallRules" -ApiKey $ApiKey
        if($OldRulesObject){
            foreach($rule in $OldRulesObject.rules){
                Write-Verbose -Message "Successfully queried the API for current firewall rules"
                Write-Verbose -Message "Rule comment: $($rule.comment)"
                Write-Verbose -Message "Rule policy: $($rule.policy)"
                Write-Verbose -Message "-----------------------------"
            }
        }

        Write-Verbose -Message "Passing old rules and new rules to process the new complete firewall rule list"
        try {
            $L3FirewallRules = New-PRL3FirewallObject -OldRulesObject $OldRulesObject.rules -NewRulesObject $NewRulesObject -PlaceOnTop $PlaceOnTop
        }
        catch {
            Write-Error -Message "$($_)"
        }

        if($L3FirewallRules){
            Write-Verbose "Found L3 Firewall Rules Object. Initiating PUT request to Meraki API"
            $Payload = [PSCustomObject]@{
                "rules" = $L3FirewallRules
            }
            
            try {
                Write-Verbose "Sending new rules to Meraki API for network $($Id)"
                Invoke-PRMerakiApiCall -Method PUT -Resource "/networks/$($Id)/appliance/firewall/l3FirewallRules" -ApiKey $ApiKey -Payload $Payload
            }
            catch {
                Write-Error "$($_)"
            }
        }
    }

    End {
        $FinishedRulesList = Invoke-PRMerakiApiCall -Method GET -Resource "/networks/$($Id)/appliance/firewall/l3FirewallRules" -ApiKey $ApiKey
        if($FinishedRulesList.comment -contains $Comment) {
            Write-Verbose -Message "The new rule was successfully applied."
        }
        else {
            Write-Warning "Couldn't find the newly created firewall rule."
        }
    }
}
Export-ModuleMember -Function Set-SCMrkL3FirewallRule
#EndRegion - Set-SCMrkL3FirewallRule.ps1
#Region - Set-SCMrkNetworkSNMP.ps1
function Set-SCMrkNetworkSNMP {
    <#
    .SYNOPSIS
        Cmdlet for setting SNMP configurations on a specific Meraki Network.
    .DESCRIPTION
        Cmdlet for setting SNMP configurations on a specfic Meraki Network. This cmdlet can be used
        for setting either Version 1/2c or 3 on a Meraki Network. You will still need to configure 
        access in the L3 firewall besides setting this configuration.
    .EXAMPLE
        PS C:\> Set-SCMrkNetworkSNMP -Id L_918231134598135 -SetCommunity -CommunityString "Password1"
        
        This example will configure SNMP V1/2c for the network L_918231134598135. It will set the Community String:
        Password1
    
    .EXAMPLE
        PS C:\> Set-SCMrkNetworkSNMP -Id L_918231134598135 -SetUsers -UserPass "Password1" -UserName "User1"
        
        This example will configure SNMP V3 for the network L_918231134598135. It will set a user with Username: User1
        and Password: Password1. If there are already a user configured it will just add the user to the list.
    
    .EXAMPLE
        PS C:\> Set-SCMrkNetworkSNMP -Id L_918231134598135 -DisableSNMP

        This example will disable SNMP on the network. All SNMP configurations such as users for Version 3 will be erased.
    .NOTES
        Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!update-network-snmp
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$Id,
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$ApiKey = $ApiKey,
        [Parameter(Mandatory=$false, ParameterSetName="Community")]
        [Switch]$SetCommunity,
        [Parameter(Mandatory=$true, ParameterSetName="Community")]
        [String]$CommunityString,
        [Parameter(Mandatory=$false, ParameterSetName="V3")]
        [Switch]$SetUsers,
        [Parameter(Mandatory=$true, ParameterSetName="V3")]
        [String]$UserPass,
        [Parameter(Mandatory=$true, ParameterSetName="V3")]
        [String]$UserName,
        [Parameter(Mandatory=$false, ParameterSetName="Disable")]
        [Switch]$DisableSNMP

    )

    Begin {
        if($SetCommunity.IsPresent){
            Write-Verbose -Message "SNMP V1/V2c has been chosen"
        }
        elseif($SetUsers.IsPresent){
            Write-Verbose -Message "SNMP V3 has been chosen"
        }
        elseif($DisableSNMP.IsPresent){
            Write-Verbose -Message "Disabling SNP has been chosen"
            $Disable = $true
        }
        elseif($SetCommunity.IsPresent -and $SetUsers.IsPresent){
            Write-Error 'You may not set both -SetCommunity and -SetUsers Switch parameter. You may only specify one of them.'
            Exit
        }
        else {
            Write-Error -Message "You need to set either -SetCommunity switch or -SetUsers switch."
            Exit
        }
    }

    Process {
        if(!$Disable){
            if($SetCommunity.IsPresent){
                Write-Verbose -Message "Setting SNMP V1/V2c configurations for network: $($Id)"
                $payload = New-Object -TypeName PSObject -Property @{
                    "access" = "community"
                    "communityString" = "$($CommunityString)"
                }
            }
            elseif($SetUsers.IsPresent){
                Write-Verbose -Message "Setting SNMP V3 configurations for network: $($Id)"
                $NewUsersObject = New-Object -TypeName psobject -Property @{
                    "username" = "$($UserName)"
                    "passphrase" = "$($UserPass)"
                }

                try {
                    $result = Invoke-PRMerakiApiCall -Method GET -Resource "/networks/$($Id)/snmp" -ApiKey $ApiKey
                    if($result.users){
                        $OldUsersObject = $result.users
                    }
                    else{
                        Write-Verbose -Message "No snmp user configurations was found"
                    }
                }
                catch {
                    Write-Error "$($_)"
                }

                if($OldUsersObject){
                    Write-Verbose -Message "OldUsersObject was found generating payload"
                    $UsersObject = New-PRSNMPUsersObject -OldUsersObject $OldUsersObject -NewUsersObject $NewUsersObject
                    $payload = New-Object -TypeName PSObject -Property @{
                        "users" = $UsersObject
                        "access" = "users"
                    }
                }
                else {
                    Write-Verbose -Message "No oldUsersObject was found, generating new"
                    $ArrayObject = New-Object System.Collections.ArrayList
                    $ArrayObject.Add($NewUsersObject)
                    $payload = New-Object -TypeName PSObject -Property @{
                        "users" = $ArrayObject
                        "access" = "users"
                    }
                }
            }
        }
        else {
            Write-Warning -Message "Disabling SNMP for network: $($Id)"
            $payload = New-Object -TypeName PSObject -Property @{
                "access" = "none"
            }
        }

        if($payload){
            Write-Verbose -Message "payload has been created sending HTTP request to the API"
            Write-Output -InputObject ($payload | ConvertTo-Json)
            
            try {
                $result = Invoke-PRMerakiApiCall -Method PUT -Resource "/networks/$($Id)/snmp" -ApiKey $ApiKey -Payload $payload
            }
            catch {
                Write-Error "$($_)"
            }
        }
    }

    End {
        $users = Invoke-PRMerakiApiCall -Method GET -Resource "/networks/$($Id)/snmp" -ApiKey $ApiKey
        if($users.users.username -contains $UserName){
            Write-Verbose -Message "User was successfully added to snmp configurations"
        }
    }
}
Export-ModuleMember -Function Set-SCMrkNetworkSNMP
#EndRegion - Set-SCMrkNetworkSNMP.ps1
#Region - Set-SCMrkSwitchPort.ps1
function Set-SCMrkSwitchPort {
    <#
    .SYNOPSIS
        Short description
    .DESCRIPTION
        Long description
    .EXAMPLE
        PS C:\> <example usage>
        Explanation of what the example does
    .INPUTS
        Inputs (if any)
    .OUTPUTS
        Output (if any)
    .NOTES
        General notes
    #>

    [CmdletBinding()]
    param (
        # Default Cmdlet Parameters
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$ApiKey = $ApiKey,

        # Default Switch Port Parameters
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$Serial,
        [Parameter(Mandatory=$true)]
        [String]$PortId,
        [Parameter(Mandatory=$true, HelpMessage="Enter descriptive name of the port")]
        [String]$Name,
        [Parameter(Mandatory=$false)]
        [Boolean]$Enabled = $true,
        [Parameter(Mandatory=$false)]
        [Boolean]$poeEnabled = $true,
        [Parameter(Mandatory=$true, HelpMessage="Enter a VLAN Id")]
        [String]$Vlan,
        [Parameter(Mandatory=$false)]
        [String]$VoiceVlan,
        [Parameter(Mandatory=$false)]
        [Boolean]$isolationEnabled = $false,
        [Parameter(Mandatory=$false)]
        [Boolean]$rstpEnabled = $true,
        [Parameter(Mandatory=$false)]
        [String]$stpGuard = "disabled",
        [Parameter(Mandatory=$false)]
        [String]$LinkNegotiation = "Auto negotiate",
        [Parameter(Mandatory=$false)]
        [String]$udld = "Alert only",

        # Default Access Port Parameters
        [Parameter(Mandatory=$false, ParameterSetName="access")]
        [Switch]$AccessPort,
        [Parameter(Mandatory=$false, ParameterSetName="access")]
        [String]$AccessPolicy = "Open",

        # Default Trunk Port Parameters
        [Parameter(Mandatory=$false, ParameterSetName="trunk")]
        [Switch]$TrunkPort,
        [Parameter(Mandatory=$false, ParameterSetName="trunk")]
        [String]$AllowedVlans
    )

    Begin {
        if($AccessPort.IsPresent){
            Write-Verbose -Message "Configuring Port: $($PortId) as an Access Port"
        }
        elseif($TrunkPort.IsPresent){
            Write-Verbose -Message "Configuring Port $($PortId) as a Trunk Port"
        }
        else {
            Write-Error -Message "Neither of -AccessPort or -TrunkPort Switches where set as a parameter. Exiting function."
            Exit
        }
    }

    Process {

        if($AccessPort.IsPresent){
            Write-Verbose -Message "Creating Access Port Data Object"
            $payload = New-Object -TypeName PSObject -Property @{
                "portId"                = $PortId
                "name"                  = $Name
                "enabled"               = $Enabled
                "poeEnabled"            = $poeEnabled
                "type"                  = "access"
                "vlan"                  = $Vlan
                "voiceVlan"             = $VoiceVlan
                "allowedVlans"          = ""
                "isolationEnabled"      = $IsolationEnabled
                "rstpEnabled"           = $rstpEnabled
                "stpGuard"              = $stpGuard
                "linkNegotiation"       = $LinkNegotiation
                "udld"                  = $udld
                "accessPolicyType"      = $AccessPolicy
            }
            if(!$VoiceVlan){
                $payload = $payload | Select-Object -ExcludeProperty voiceVlan
            }
        }
        elseif($TrunkPort.IsPresent){
            Write-Verbose -Message "Creating Trunk Port Data Object"
            $payload = New-Object -TypeName PSObject -Property @{
                "portId"                = $PortId
                "name"                  = $Name
                "enabled"               = $Enabled
                "poeEnabled"            = $poeEnabled
                "type"                  = "trunk"
                "vlan"                  = $Vlan
                "allowedVlans"          = $AllowedVlans
                "isolationEnabled"      = $IsolationEnabled
                "rstpEnabled"           = $rstpEnabled
                "stpGuard"              = $stpGuard
                "linkNegotiation"       = $LinkNegotiation
                "udld"                  = $udld
            }
        }
        
        try {
            $result = Invoke-PRMerakiApiCall -Method PUT -Resource "/devices/$($Serial)/switch/ports/$($PortId)" -ApiKey $ApiKey -Payload $payload
        }
        catch {
            Write-Error -Message "$($_)"
        }
        

    }

    End {
        if($result){
            try {
                $request =  Invoke-PRMerakiApiCall -Method GET -Resource "/devices/$($Serial)/switch/ports/$($PortId)" -ApiKey $ApiKey
                return $request
            }
            catch {
                Write-Error -Message "$($_)"
            }
        }
    }
}
Export-ModuleMember -Function Set-SCMrkSwitchPort
#EndRegion - Set-SCMrkSwitchPort.ps1
### --- PRIVATE FUNCTIONS --- ###
#Region - Invoke-PRMerakiApiCall.ps1
function Invoke-PRMerakiApiCall {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [ValidateSet("POST", "GET", "PUT", "DELETE")]
        [String]$Method,
        [Parameter(ValueFromPipeline=$true, Mandatory=$true)]
        [String]$Resource,
        [Parameter(Mandatory=$true)]
        [String]$ApiKey,
        [Parameter(Mandatory=$false)]
        [object]$Payload
    )

    begin {
        Write-Verbose -Message "Setting the API Key $($ApiKey) as a Script Varaible"
        New-Variable -Name ApiKey -Value $ApiKey -Scope Script -Force
        
        $baseUrl = "https://api.meraki.com/api/v1/"
        Write-Verbose -Message "Setting the base url: "

        $headers = @{
            "Content-Type" = "application/json"
            "Accept" = "application/json"
            "X-Cisco-Meraki-API-Key" = $ApiKey
        }
        Write-Verbose -Message "Setting the API Call headers"
    }

    process {
        if(!$Payload) {
            Write-Verbose -Message "Invoking the API call with uri: $($baseUrl)/$($Resource) and the Method: $($Method)"
            try {
                $result = Invoke-RestMethod -Uri $baseUrl/$Resource -Method $Method -Headers $headers
                return $result
            }
            catch {
                $statusCode = $_.Exception.Response.StatusCode.value__
                $statusDescription = $_.Exception.Response.StatusDescription
            }
        }
        elseif($Payload) {
            Write-Verbose -Message "Invoking the API call with uri: $($baseUrl)/$($Resource) and the Method: $($Method) with a Payload"
            $Body = $Payload | ConvertTo-Json
            if($Body){
                Write-Verbose "Payload was create. Sending HTTP Request"
                try {
                    $result = Invoke-RestMethod -Uri $baseUrl/$Resource -Method $Method -Headers $headers -Body $Body
                    return $result
                }
                catch {
                    Write-Error "$($_)"
                    $statusCode = $_.Exception.Response.StatusCode.value__
                    $statusDescription = $_.Exception.Response.StatusDescription
                }
            }
            else {
                Write-Warning "Payload couldn't be found"
            }
        }
    }

    end {
        if(!($result)){
            Write-Error -Message " HTTP Status Code: $($statusCode) - Error Description: $statusDescription"
        }
    }
}
#EndRegion - Invoke-PRMerakiApiCall.ps1
#Region - New-PRL3FirewallObject.ps1
function New-PRL3FirewallObject {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [Object]$OldRulesObject,
        [Parameter(Mandatory=$true)]
        [Object]$NewRulesObject,
        [Parameter(Mandatory=$false)]
        [Boolean]$PlaceOnTop
    )

    Begin {
        Write-Verbose -Message "Creating a new Rules object to set the firewall rules from"
    }

    Process {
        if($PlaceOnTop -eq $true){
            Write-Verbose -Message "Generating the new Rules object with the new rule in the top"
            $RulesObject = New-Object System.Collections.ArrayList
            $null = $RulesObject.Add($NewRulesObject)

            foreach($rule in $OldRulesObject){
                $object = New-Object -TypeName PSObject -Property @{
                    "comment"       = "$($rule.comment)"
                    "policy"        = "$($rule.policy)"
                    "protocol"      = "$($rule.protocol)"
                    "srcPort"       = "$($rule.srcPort)"
                    "srcCidr"       = "$($rule.srcCidr)"
                    "destPort"      = "$($rule.destPort)"
                    "destCidr"      = "$($rule.srcCidr)"
                    "syslogEnabled" = "$($rule.syslogEnabled)"
                }

                $null = $RulesObject.Add($object)
            }

            return $RulesObject
        }
        elseif($PlaceOnTop -eq $false) {
            Write-Verbose -Message "Generating the new Rules object with the new rule in the bottom"
            $RulesObject = New-Object System.Collections.ArrayList
                foreach($rule in $OldRulesObject){
                    $object = New-Object -TypeName PSObject -Property @{
                        "comment"       = "$($rule.comment)"
                        "policy"        = "$($rule.policy)"
                        "protocol"      = "$($rule.protocol)"
                        "srcPort"       = "$($rule.srcPort)"
                        "srcCidr"       = "$($rule.srcCidr)"
                        "destPort"      = "$($rule.destPort)"
                        "destCidr"      = "$($rule.srcCidr)"
                        "syslogEnabled" = "$($rule.syslogEnabled)"
                    }
                    $null = $RulesObject.Add($object)
                }

                $null = $RulesObject.Add($NewRulesObject)
                return $RulesObject
            }
        }

    End {
        if($RulesObject){
            Write-Verbose -Message "Sucussfully created a Rules Object"
            foreach($rule in $RulesObject){
                Write-Verbose -Message "Rule comment: $($rule.comment)"
                Write-Verbose -Message "Rule policy: $($rule.policy)"
                Write-Verbose -Message "-----------------------------"
            }
        }
        else {
            Write-Verbose -Message "Couldn't find any rules object created."
        }
    }
}
#EndRegion - New-PRL3FirewallObject.ps1
#Region - New-PRSNMPUsersObject.ps1
function New-PRSNMPUsersObject {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [Array]$OldUsersObject,
        [Parameter(Mandatory=$true)]
        [Object]$NewUsersObject
    )

    Write-Verbose -Message "Compiling the two users object into a single array object"
    $UsersObject = New-Object System.Collections.ArrayList
    Write-Verbose -Message "Generating the new object"
    foreach($user in $OldUsersObject){
        $object = New-Object -TypeName psobject -Property @{
            "username" = "$($user.username)"
            "passphrase" = "$($user.passphrase)"
        }
        $null = $UsersObject.Add($object)
    }
    
    try {
        Write-Verbose "Adding the new users to the old users array"
        $null = $UsersObject.Add($NewUsersObject)
        foreach($user in $UsersObject){
            Write-Verbose -Message "User: $($user.username)"
            Write-Verbose -Message "Passphrase: $($user.passphrase)"
        }
        return $UsersObject
    }
    catch {
        Write-Error -Message $($_)
    }
}
#EndRegion - New-PRSNMPUsersObject.ps1
