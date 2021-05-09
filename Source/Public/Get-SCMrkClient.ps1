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
