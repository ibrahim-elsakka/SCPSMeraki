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
        n/a
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
    .INPUTS
        System.String[] - You can pipe the Serial into the cmdlet
    .OUTPUTS
        System.Object[] - This cmdlet will output a PS Object with data on the specific device.
    .NOTES
        n/a
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
    .INPUTS
        System.String[] - You can pipe the Serial into the cmdlet
    .OUTPUTS
        System.Array[] - The cmdlet will output an PS Object with an array of all the clients associated to a specific device.
    .NOTES
        n/a
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
#Region - Get-SCMrkDevices.ps1
function Get-SCMrkDevices {
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
        PS C:\> (Get-SCMrkNetworks | ? Name -eq "Network1").Id | Get-SCMrkDevices

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
        n/a
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
Export-ModuleMember -Function Get-SCMrkDevices
#EndRegion - Get-SCMrkDevices.ps1
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
        n/a
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
        [String]$ApiKey    
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

    end {
        if(!($result)){
            Write-Error -Message " HTTP Status Code: $($statusCode) - Error Description: $statusDescription"
        }
    }
}
#EndRegion - Invoke-PRMerakiApiCall.ps1
