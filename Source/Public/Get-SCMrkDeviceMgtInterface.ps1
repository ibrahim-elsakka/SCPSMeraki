function Get-SCMrkDeviceMgtInterface {
    <#
    .SYNOPSIS
        Cmdlet for retrieving information on Device Management Interface
    .DESCRIPTION
        This cmdlet will return an  Object containing configuration information
        on the Device Management interface of a specified device.
    .EXAMPLE
        PS C:\> Get-SCMrkDeviceManagementInterface -Serial QXLA-23BA-LS98
        
        This example will retrive the configurations made for the Device Management interface
        on the device: QXLA-23BA-LS98
    .NOTES
        Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!get-device-management-interface
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
        Write-Verbose -Message "Initiating retrieval Management Interface information on device: $($Serial)"
    }

    Process {
        try {
            Write-Verbose -Message "Retrieving Meraki Management Interface"
            $result = Invoke-PRMerakiApiCall -Method GET -Resource "/devices/$($Serial)/managementInterface" -ApiKey $ApiKey
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