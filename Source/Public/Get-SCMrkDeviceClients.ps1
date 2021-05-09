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