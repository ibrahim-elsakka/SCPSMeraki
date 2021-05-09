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
