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