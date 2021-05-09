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